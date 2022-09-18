Class {
	#name : #QuadTreeVisualizer,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'quadTree'
	],
	#category : #'QuadTree-UI'
}

{ #category : #hooks }
QuadTreeVisualizer >> createPointFor: aQuadPoint [

    ^ RSCircle new
        model: aQuadPoint;
			extent: 10@10; 
			x: aQuadPoint x;
			y: aQuadPoint y;
        popup;
        draggable;
        yourself
]

{ #category : #accessing }
QuadTreeVisualizer >> quadTree: aQuadTree [

	quadTree := aQuadTree
]

{ #category : #hooks }
QuadTreeVisualizer >> renderIn: aCanvas [
	
	| circles |
	circles := quadTree allData collect: [ :each | self createPointFor: each ].
	aCanvas addAll: circles.

	
]
