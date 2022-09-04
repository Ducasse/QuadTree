Class {
	#name : #CTQuadPoint,
	#superclass : #Object,
	#instVars : [
		'point',
		'object'
	],
	#category : #QuadTree
}

{ #category : #'instance creation' }
CTQuadPoint class >> x: anInteger y: anInteger2 object: anObject [ 
	
	^ self new 
		setX: anInteger 
		y: anInteger2 
		object: anObject
]

{ #category : #testing }
CTQuadPoint >> isIn: aRectangle [ 
	^ aRectangle containsPoint: point
]

{ #category : #accessing }
CTQuadPoint >> object [
	^ object
]

{ #category : #private }
CTQuadPoint >> setX: anInteger y: anInteger2 object: anObject [ 
	
	point := anInteger @ anInteger2.
	object := anObject
]

{ #category : #accessing }
CTQuadPoint >> x [
	^ point x
]

{ #category : #accessing }
CTQuadPoint >> y [
	^ point y
]
