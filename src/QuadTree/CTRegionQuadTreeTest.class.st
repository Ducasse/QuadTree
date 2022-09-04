Class {
	#name : #CTRegionQuadTreeTest,
	#superclass : #TestCase,
	#category : #QuadTree
}

{ #category : #tests }
CTRegionQuadTreeTest >> testEmptyTree [
	
	| tree |
	tree := CTRegionQuadTree new.
	self assert: tree isLeaf.
	self assert: tree rectangle equals: (0@0 corner: 100@100)
]
