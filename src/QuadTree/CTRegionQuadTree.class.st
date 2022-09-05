"
A region quad tree is a tree with 4 nodes.
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
	data := aCTQuadPoint.
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

{ #category : #private }
CTRegionQuadTree >> quadrantOf: aPoint [ 
	"Precondition: aPoint is within bounds of parent".
	
	^ aPoint x < topRightNode x 
		ifTrue: [ 
			"left column"
			aPoint y < topRightNode y
				ifTrue: [ topLeftNode ] 
				ifFalse: [ ] ]
		ifFalse: [ 
			"right column" ]
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
