Class {
	#name : #CTRegionQuadTree,
	#superclass : #Object,
	#instVars : [
		'topLeftNode',
		'rectangle'
	],
	#category : #QuadTree
}

{ #category : #accessing }
CTRegionQuadTree >> initialize [ 
	super initialize.
	rectangle := 0@0 corner: 100@100
]

{ #category : #testing }
CTRegionQuadTree >> isLeaf [
	^ topLeftNode isNil 
]

{ #category : #accessing }
CTRegionQuadTree >> rectangle [
	^ rectangle
]
