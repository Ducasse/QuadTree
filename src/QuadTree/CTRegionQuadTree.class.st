"
A PR (point region) quad tree following Sanet definition.
A PR quadTree is a 2D tree as such it has a bounds and this bounds is divided in its children.

It is either 
- one node with its data or 
- a node (and no data because each child will have its own) with 4 children nodes.
Each node has at most 1 data element.


"
Class {
	#name : #CTRegionQuadTree,
	#superclass : #Object,
	#instVars : [
		'topLeftNode',
		'data',
		'topRightNode',
		'bottomRightNode',
		'bottomLeftNode',
		'bounds'
	],
	#category : #QuadTree
}

{ #category : #'instance creation' }
CTRegionQuadTree class >> bounds: aRectangle [ 
	^ self new bounds: aRectangle ; yourself
]

{ #category : #'instance creation' }
CTRegionQuadTree class >> extent: aPoint [ 
	^ self new bounds: (0@0 corner: aPoint); yourself
]

{ #category : #examples }
CTRegionQuadTree class >> fourPoints [
	<sampleInstance> 
	
	| tree all |
	tree := self new.
	all := { CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	CTQuadPoint x: 62 y: 77 object: 'Toronto'.
	CTQuadPoint x: 82 y: 65 object: 'Buffalo'}.
	tree addAll: all.
	^ tree
]

{ #category : #examples }
CTRegionQuadTree class >> troisPoints [
	<sampleInstance> 
	
	| tree point point2 point3 |
	tree := self new.
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	point2 := CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	point3 := CTQuadPoint x: 62 y: 77 object: 'Toronto'.
	tree add: point; add: point2; add: point3.
	^ tree
]

{ #category : #adding }
CTRegionQuadTree >> add: aCTQuadPoint [
	"we will have to think here.
	if the point is part of a quadrant that is a leaf then we should split that leaf and add it there.
	else it can just be added to a empty quadrant.
	"
	
	(bounds containsPoint: aCTQuadPoint) 
		ifFalse: [ ^ self ].
	(self isLeaf and: [ self isEmpty]) 
		ifTrue: [ data := aCTQuadPoint ]
		ifFalse: [ 
				self isLeaf 
					ifFalse: [ "it was split, pick up the correct quads"
						(self quadrantOf: aCTQuadPoint) add: aCTQuadPoint
						 ]
					ifTrue: [  
						self split.
						(self quadrantOf: data) add: data.
						data := nil.
						(self quadrantOf: aCTQuadPoint) add: aCTQuadPoint
				]]
]

{ #category : #adding }
CTRegionQuadTree >> addAll: aCollection [ 

	aCollection do: [ :each | self add: each ]
]

{ #category : #accessing }
CTRegionQuadTree >> allData [

	| col | 
	col := OrderedCollection new.
	self do: [ :each | each hasData ifTrue: [  col add: each data ]  ].
	^ col
]

{ #category : #accessing }
CTRegionQuadTree >> bottomLeftNode [
	^ bottomLeftNode
]

{ #category : #accessing }
CTRegionQuadTree >> bottomRightNode [
	^ bottomRightNode
]

{ #category : #accessing }
CTRegionQuadTree >> bounds [
	^ bounds
]

{ #category : #accessing }
CTRegionQuadTree >> bounds: aRectangle [ 
	bounds := aRectangle
]

{ #category : #accessing }
CTRegionQuadTree >> children [
	
	^ self isLeaf 
		ifTrue: [ #()] 	
		ifFalse: { topLeftNode . topRightNode . bottomRightNode . bottomLeftNode }
]

{ #category : #accessing }
CTRegionQuadTree >> childrenDo: aBlockClosure [

	"it looks a bit defensive to me. because on split we should allocate all the children."
	topLeftNode ifNotNil: aBlockClosure.
	topRightNode ifNotNil: aBlockClosure.
	bottomRightNode ifNotNil: aBlockClosure.
	bottomLeftNode ifNotNil: aBlockClosure.

]

{ #category : #accessing }
CTRegionQuadTree >> data [
	^ data
]

{ #category : #accessing }
CTRegionQuadTree >> data: anObject [
	data := anObject
]

{ #category : #'accessing - defaults' }
CTRegionQuadTree >> defaultContainer [
	^ super defaultContainer @ RSCanvasController
]

{ #category : #iteration }
CTRegionQuadTree >> do: aBlock [
	"Execute the argument on every nodes."
	
	self isLeaf
		ifTrue: [ aBlock value: self ]
		ifFalse: [ self subQuadsDo: aBlock ]
]

{ #category : #'looking for' }
CTRegionQuadTree >> elementsWithin: aRectangle [ 
	
	(self bounds intersects: aRectangle)
		ifFalse: [ ^ #() ]	
	
	 
]

{ #category : #testing }
CTRegionQuadTree >> hasData [
	^ data isNotNil
]

{ #category : #accessing }
CTRegionQuadTree >> height [
	^ bounds height
]

{ #category : #initialization }
CTRegionQuadTree >> initialize [ 
	super initialize.
	bounds := 0@0 corner: 100@100
]

{ #category : #testing }
CTRegionQuadTree >> isEmpty [
	"A tree node may be empty, e.g. it has been created but there is no data attached to it."
	
	^ data isNil 
]

{ #category : #testing }
CTRegionQuadTree >> isLeaf [
	"A leaf is a node which does not have children."
	
	^ topLeftNode isNil 
]

{ #category : #accessing }
CTRegionQuadTree >> numberOfNodes [
	
	| count |
	count := 0.
	self do: [ :each | count := count + 1 ].
	^ count
]

{ #category : #printing }
CTRegionQuadTree >> printOn: aStream [

	super printOn: aStream.
	self isLeaf 	
		ifTrue: [ aStream nextPutAll: '[Leaf with ' ; print: data; nextPutAll: ']' ] 
		ifFalse: [ aStream nextPutAll: ' [Split]' ]
	
]

{ #category : #private }
CTRegionQuadTree >> quadrantOf: aPoint [
	| center corner |
	center := bounds center.
	corner := bounds corner.

	^ aPoint x < center x
		ifTrue: [
			aPoint y < center y
				ifTrue: [ topLeftNode ]
				ifFalse: [ bottomLeftNode ] ]
		ifFalse: [
			aPoint y < center y
				ifTrue: [ topRightNode ]
				ifFalse: [ bottomRightNode ] ]

]

{ #category : #private }
CTRegionQuadTree >> split [
	"Create four children nodes"

	| center origin corner |
	center := bounds floatCenter.
	origin := bounds origin.
	corner := bounds corner.

	topLeftNode := self class bounds: (origin corner: center).
	bottomLeftNode := self class bounds: (origin x @ center y corner: center x @ corner y).
	topRightNode := self class bounds: (center x @ origin y corner: corner x @ center y).
	bottomRightNode := self class bounds: (center corner: corner).
]

{ #category : #iteration }
CTRegionQuadTree >> subQuadsDo: aBlock [

	self topLeftNode do: aBlock.
	self topRightNode do: aBlock.
	self bottomRightNode do: aBlock.
	self bottomLeftNode do: aBlock.
]

{ #category : #accessing }
CTRegionQuadTree >> topLeftNode [
	^ topLeftNode
]

{ #category : #accessing }
CTRegionQuadTree >> topRightNode [
	^ topRightNode
]

{ #category : #accessing }
CTRegionQuadTree >> width [
	^ bounds width
]
