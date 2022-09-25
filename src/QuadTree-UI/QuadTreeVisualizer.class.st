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

	^ RSEllipse new
		  model: aQuadPoint;
		  size: 10;
		  x: aQuadPoint x * 5;
		  y: aQuadPoint y * 5;
		  popup;
		  draggable;
		  yourself
]

{ #category : #'accessing - defaults' }
QuadTreeVisualizer >> defaultContainer [
	^ super defaultContainer 
		addInteraction: CTOriginAtBottomLeftInteraction new;
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
	aCanvas addAll: circles
]
