"
I'm a point holding some data for a region quad tree. 
Note that I could have been merged in the quad tree.
"
Class {
	#name : #CTQuadPoint,
	#superclass : #Magnitude,
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

{ #category : #comparing }
CTQuadPoint >> < aPoint [ 
	"Answer whether the receiver is above and to the left of aPoint."
	
	^ point < aPoint
]

{ #category : #comparing }
CTQuadPoint >> = aQuadPoint [ 
	"Answer whether the receiver is above and to the left of aPoint."
	
	^ point = aQuadPoint point and: [ object = aQuadPoint object  ]
]

{ #category : #comparing }
CTQuadPoint >> hash [  
	
	^ point hash bitXor: object hash
]

{ #category : #testing }
CTQuadPoint >> isIn: aRectangle [ 
	^ aRectangle containsPoint: point
]

{ #category : #accessing }
CTQuadPoint >> object [
	^ object
]

{ #category : #accessing }
CTQuadPoint >> point [
	^ point
]

{ #category : #printing }
CTQuadPoint >> printOn: aStream [

	self x printOn: aStream.
	aStream nextPut: $@.
	self y printOn: aStream.
	aStream nextPut: Character space.
	self object printOn: aStream.
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
