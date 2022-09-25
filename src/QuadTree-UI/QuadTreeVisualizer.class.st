Class {
	#name : #QuadTreeVisualizer,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'quadTree',
		'pointSize'
	],
	#category : #'QuadTree-UI'
}

{ #category : #hooks }
QuadTreeVisualizer >> createPointFor: aQuadPoint [

	^ RSEllipse new
		  model: aQuadPoint;
		  size: self pointSize;
		  x: aQuadPoint x;
		  y: aQuadPoint y;
		  popup;
		  draggable;
		  yourself
]

{ #category : #'accessing - defaults' }
QuadTreeVisualizer >> defaultContainer [
	^ super defaultContainer 
		addInteraction: CTOriginAtBottomLeftInteraction new;
		addInteraction: RSZoomToFitCanvasInteraction new;
		addInteraction: (RSMenuActivable new menuDo: [ :menu :element | menu add: 'Inspect' target: element model selector: #inspect ])
		yourself
]

{ #category : #hooks }
QuadTreeVisualizer >> defaultPointSize [

	^ 2
]

{ #category : #hooks }
QuadTreeVisualizer >> drawBorderOn: aCanvas [
	
	
	quadTree do: [:each | each drawBorderOn: aCanvas]
	


]

{ #category : #hooks }
QuadTreeVisualizer >> initialize [ 
	super initialize. 
	pointSize := self defaultPointSize 
]

{ #category : #hooks }
QuadTreeVisualizer >> pointSize [

	^ pointSize
]

{ #category : #hooks }
QuadTreeVisualizer >> pointSize: anInteger [

	pointSize := anInteger
]

{ #category : #accessing }
QuadTreeVisualizer >> quadTree: aQuadTree [

	quadTree := aQuadTree
]

{ #category : #hooks }
QuadTreeVisualizer >> renderIn: aCanvas [

	| circles |
	aCanvas when: RSMouseClick do: [ :evt |
			quadTree add: (CTQuadPoint point: evt position object: 'OnTheFly')  ].
	self drawBorderOn: aCanvas.
	circles := quadTree allData collect: [ :each | self createPointFor: each ].
	aCanvas addAll: circles
]
