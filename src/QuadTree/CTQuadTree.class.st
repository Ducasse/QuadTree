"
used to navigate between big models, quadtree is used
"
Class {
	#name : #CTQuadTree,
	#superclass : #Object,
	#instVars : [
		'rectangle',
		'soleChild',
		'northWestQuad',
		'northEastQuad',
		'southWestQuad',
		'southEastQuad',
		'isLeaf'
	],
	#category : #QuadTree
}

{ #category : #public }
CTQuadTree class >> position: aShape [
	^ aShape position
]

{ #category : #'instance creation' }
CTQuadTree class >> withAll: aRSGroup [
	^ self
		withAll: aRSGroup
		rectangle: (Rectangle encompassing: (aRSGroup collect: [:each | self position: each ]))
]

{ #category : #'instance creation' }
CTQuadTree class >> withAll: aRSGroup rectangle: rectangle [
	| root extent |
	extent := rectangle extent.
	
	(extent x closeTo: extent y) ifTrue: [ 
		root := self new.
		root rectangle: rectangle.
		aRSGroup do: [ :shape | root add: shape ].
		^ root ].
	
	^ extent x > extent y
		ifTrue: [ 
			self 
				withAll: aRSGroup
				rectangle: (rectangle origin 
					corner: rectangle corner x @ (extent x + rectangle origin y)) ]
		ifFalse: [
			self 
				withAll: aRSGroup
				rectangle: (rectangle origin 
					corner: (extent y + rectangle origin x) @ rectangle corner y) ]


]

{ #category : #adding }
CTQuadTree >> add: aShape [
	isLeaf ifTrue: [ 
		soleChild
			ifNil: [ soleChild := aShape ]
			ifNotNil: [ 
				((self position: soleChild) closeTo: (self position: aShape))
					ifTrue: [ self addChild: aShape ]
					ifFalse: [ 
						| firstChild |
						firstChild := soleChild.
						soleChild := nil.
						self
							addChild: aShape;
							addChild: firstChild ] ] ]
	ifFalse: [ self addChild: aShape ]
]

{ #category : #adding }
CTQuadTree >> addChild: aShape [
	| center origin corner position |
	isLeaf := false.
	center := rectangle floatCenter.
	origin := rectangle origin.
	corner := rectangle corner.
	position := self position: aShape.

	position x < center x
		ifTrue: [
			position y < center y
				ifTrue: [
					northWestQuad ifNil: [ 
						northWestQuad := self class new
							rectangle: (origin corner: center);
							yourself ].
					northWestQuad add: aShape ]
				ifFalse: [
					southWestQuad ifNil: [ 
						southWestQuad := self class new
							rectangle: ((origin x @ center y ) corner: (center x @ corner y));
							yourself ].
					southWestQuad add: aShape ] ]
		ifFalse: [
			position y < center y
				ifTrue: [
					northEastQuad ifNil: [
						northEastQuad := self class new
							rectangle: ((center x @ origin y) corner: (corner x @ center y));
							yourself ].
					northEastQuad add: aShape ]
				ifFalse: [
					southEastQuad ifNil: [ 
						southEastQuad := self class new
							rectangle: (center corner: corner);
							yourself ].
					southEastQuad add: aShape ] ]

]

{ #category : #initialization }
CTQuadTree >> initialize [ 
	super initialize.
	isLeaf := true

]

{ #category : #testing }
CTQuadTree >> isLeaf [
	^ isLeaf
]

{ #category : #accessing }
CTQuadTree >> position: aShape [
	^ self class position: aShape.
]

{ #category : #printing }
CTQuadTree >> printOn: aStream [

	self x printOn: aStream.
	aStream nextPut: $@.
	self y printOn: aStream.
	aStream nextPut: Character space.
	self object printOn: aStream.
]

{ #category : #accessing }
CTQuadTree >> rectangle [
	^ rectangle
]

{ #category : #accessing }
CTQuadTree >> rectangle: aRectangle [ 
	rectangle := aRectangle
]

{ #category : #accessing }
CTQuadTree >> soleChild [
	^ soleChild
]

{ #category : #enumeration }
CTQuadTree >> subQuadsDo: aBlockClosure [
  northWestQuad ifNotNil: aBlockClosure.
  northEastQuad ifNotNil: aBlockClosure.
  southWestQuad ifNotNil: aBlockClosure.
  southEastQuad ifNotNil: aBlockClosure.

]

{ #category : #'finding/searching' }
CTQuadTree >> visibleShapesFrom: aRectangle [

	| listResult |
	listResult := OrderedCollection new.
	self visibleShapesFrom: aRectangle list: listResult.
	^ listResult
]

{ #category : #private }
CTQuadTree >> visibleShapesFrom: aRectangle list: listResult [

	(self rectangle intersects: aRectangle) ifFalse: [ ^ self ].
	self isLeaf
		ifTrue: [ 
			(self soleChild encompassingRectangle intersects: aRectangle) 
				ifTrue: [ listResult add: self soleChild ] ]
		ifFalse: [ 
			self subQuadsDo: [ :aQuad | 
				aQuad visibleShapesFrom: aRectangle list: listResult ] ]
]
