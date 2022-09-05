Class {
	#name : #CTRegionQuadTreeTest,
	#superclass : #TestCase,
	#category : #QuadTree
}

{ #category : #tests }
CTRegionQuadTreeTest >> testAddOneElement [ 
	
	| tree point |
	tree := CTRegionQuadTree new.
	point := (CTQuadPoint x: 35 y: 42 object: 'Chicago').
	tree add: point.
	self assert: tree isLeaf.
	self assert: tree data equals: point.
	self assert: tree bounds equals: (0@0 corner: 100@100)
]

{ #category : #tests }
CTRegionQuadTreeTest >> testEmptyTree [
	
	| tree |
	tree := CTRegionQuadTree new.
	self assert: tree isLeaf.
	self assert: tree bounds equals: (0@0 corner: 100@100)
]

{ #category : #tests }
CTRegionQuadTreeTest >> testEmptyTreeOfBounds [
	
	| tree |
	tree := CTRegionQuadTree bounds: (0@0 corner: 100@100).
	self assert: tree isLeaf.
	self assert: tree bounds equals: (0@0 corner: 100@100)
]

{ #category : #tests }
CTRegionQuadTreeTest >> testEmptyTreeOfExtent [
	
	| tree |
	tree := CTRegionQuadTree extent: 100@100.
	self assert: tree isLeaf.
	self assert: tree bounds equals: (0@0 corner: 100@100)
]

{ #category : #tests }
CTRegionQuadTreeTest >> testHeight [
	
	| tree |
	tree := CTRegionQuadTree bounds: (0@0 corner: 100@200).
	self assert: tree height equals: 200
]

{ #category : #tests }
CTRegionQuadTreeTest >> testQuadrantOfPointBottomLeft [
	
	| tree q |
	tree := CTRegionQuadTree new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 2 y: 72 object: 'Chicago').
	self assert: q equals: tree bottomLeftNode.
]

{ #category : #tests }
CTRegionQuadTreeTest >> testQuadrantOfPointBottomRight [
	
	| tree q |
	tree := CTRegionQuadTree new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 72 y: 52 object: 'Chicago').
	self assert: q equals: tree bottomRightNode.
]

{ #category : #tests }
CTRegionQuadTreeTest >> testQuadrantOfPointTopLeft [
	
	| tree q |
	tree := CTRegionQuadTree new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 2 y: 2 object: 'Chicago').
	self assert: q equals: tree topLeftNode.
]

{ #category : #tests }
CTRegionQuadTreeTest >> testQuadrantOfPointTopRight [
	
	| tree q |
	tree := CTRegionQuadTree new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 72 y: 2 object: 'Chicago').
	self assert: q equals: tree topRightNode.
]

{ #category : #tests }
CTRegionQuadTreeTest >> testSplitGemeotry [
	
	| tree |
	tree := CTRegionQuadTree new.
	tree split.
	self assert: tree topLeftNode bounds equals: (0@0 corner: 50@50).
	self assert: tree topRightNode bounds equals: (50@0 corner: 100@50).
	self assert: tree bottomLeftNode bounds equals: (0@50 corner: 50@100).
	self assert: tree bottomRightNode bounds equals: (50@50 corner: 100@100).
]

{ #category : #tests }
CTRegionQuadTreeTest >> testSplitInstantiates4Children [
	
	| tree |
	tree := CTRegionQuadTree new.
	tree split.
	self deny: tree isLeaf.
	self assert: tree children size equals: 4.
]

{ #category : #tests }
CTRegionQuadTreeTest >> testWidth [
	
	| tree |
	tree := CTRegionQuadTree bounds: (0@0 corner: 100@200).
	self assert: tree width equals: 100
]
