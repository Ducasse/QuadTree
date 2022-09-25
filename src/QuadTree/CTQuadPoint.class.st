"
I'm a point holding some data for a region quad tree. 
Note that I could have been merged in the quad tree.
"
Class {
	#name : #CTQuadPoint,
	#superclass : #Point,
	#instVars : [
		'object'
	],
	#category : #QuadTree
}

{ #category : #'instance creation' }
CTQuadPoint class >> point: aPoint object: anObject [ 
	
	^ self new 
		setX: aPoint x  
		y: aPoint y;
		object: anObject
]

{ #category : #'instance creation' }
CTQuadPoint class >> x: anInteger y: anInteger2 object: anObject [ 
	
	^ self new 
		setX: anInteger 
		setY: anInteger2 ;
		object: anObject
]

{ #category : #testing }
CTQuadPoint >> isIn: aRectangle [ 
	^ aRectangle containsPoint: self
]

{ #category : #accessing }
CTQuadPoint >> object [
	^ object
]

{ #category : #accessing }
CTQuadPoint >> object: anObject [ 
	
	object := anObject
]

{ #category : #printing }
CTQuadPoint >> printOn: aStream [

	self x printOn: aStream.
	aStream nextPut: $@.
	self y printOn: aStream.
	aStream nextPut: Character space.
	self object printOn: aStream.
]
