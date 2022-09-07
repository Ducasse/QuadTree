"
A PR (point region) quad tree following Sanet definition.
A PR quadTree is a 2D tree. 
It is either one node or a node with 4 children nodes.
Each node has at most 1 element.
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

{ #category : #adding }
CTRegionQuadTree >> add: aCTQuadPoint [
	"we will have to think here.
	if the point is part of a quadrant that is a leaf then we should split that leaf and add it there.
	else it can just be added to a empty quadrant.
	"
	
	(self isLeaf and: [ self isEmpty]) 
		ifTrue: [ data := aCTQuadPoint ]
		ifFalse: [ 
			| potentialSubQuad |
			self isEmpty 
				ifFalse: [ self split ].
			potentialSubQuad := (self quadrantOf: aCTQuadPoint).
			(potentialSubQuad isLeaf and: [ potentialSubQuad isEmpty])
				ifTrue: [ potentialSubQuad data: aCTQuadPoint ]
				ifFalse: [ 
					self split.
					"we dispatch the parent data to one of the children
					as the newly added point"
					(self quadrantOf: data) add: data.
					data := nil.
					(self quadrantOf: aCTQuadPoint) add: aCTQuadPoint
				]]
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

{ #category : #printing }
CTRegionQuadTree >> printOn: aStream [

	super printOn: aStream.
	self isLeaf 	
		ifTrue: [ aStream nextPutAll: ' Leaf with ' ; print: data ] 
		ifFalse: [ aStream nextPutAll: ' Split' ]
	
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
