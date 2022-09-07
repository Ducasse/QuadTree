Class {
	#name : #CTQuadPointTest,
	#superclass : #TestCase,
	#category : #QuadTree
}

{ #category : #tests }
CTQuadPointTest >> testCreatePoint [
	| point |
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	self assert: point x equals: 35.
	self assert: point y equals: 42.
	self assert: point object equals: 'Chicago'
]

{ #category : #tests }
CTQuadPointTest >> testEquals [
	| point point2 |
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	self assert: point = point.
	point2 := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	self assert: point = point2
]

{ #category : #tests }
CTQuadPointTest >> testIsInRectangle [
	| point |
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.

	self assert: (point isIn: (0@0 corner: 100@100)).
	self assert: (point isIn: (0@0 corner: 50@50)).
	self deny: (point isIn: (50@50 corner: 100@100)).
]
