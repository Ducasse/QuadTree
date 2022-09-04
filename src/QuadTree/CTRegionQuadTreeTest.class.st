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
CTRegionQuadTreeTest >> testQuadrantOfPoint [
	
	| tree  |
	self flag: #tofinish.
	tree := CTRegionQuadTree new.
	"what is the quadrant of an unsplit node? itself?"
	tree quadrantOf: (CTQuadPoint x: 2 y: 2 object: 'Chicago').
	self deny: tree isLeaf.
	self 
]

{ #category : #tests }
CTRegionQuadTreeTest >> testSplit [
	
	| tree |
	tree := CTRegionQuadTree new.
	tree split.
	self deny: tree isLeaf.
	self assert: tree children size equals: 4.
]
