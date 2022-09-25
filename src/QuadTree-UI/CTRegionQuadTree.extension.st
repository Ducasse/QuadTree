Extension { #name : #CTRegionQuadTree }

{ #category : #'*QuadTree-UI' }
CTRegionQuadTree >> drawBorderOn: aCanvas [

	| topLeftCorner topRightCorner bottomLeftCorner bottomRightCorner |
	topLeftCorner := bounds topLeft.
	topRightCorner := bounds topRight.
	bottomLeftCorner := bounds bottomLeft.
	bottomRightCorner := bounds bottomRight.
	
	aCanvas add: (RSLine new startPoint: topLeftCorner ;  endPoint: topRightCorner ; yourself).
	aCanvas add: (RSLine new startPoint: topLeftCorner ;  endPoint: bottomLeftCorner ; yourself).
	aCanvas add: (RSLine new startPoint: topRightCorner ;  endPoint: bottomRightCorner ; yourself).
	aCanvas add: (RSLine new startPoint: bottomRightCorner ;  endPoint: bottomLeftCorner; yourself).

]

{ #category : #'*QuadTree-UI' }
CTRegionQuadTree >> inspectorTreeBuilder [
    <inspectorPresentationOrder: 1 title: 'Visual'>

	^ QuadTreeVisualizer new
        quadTree: self ;
        asPresenter
]

{ #category : #'*QuadTree-UI' }
CTRegionQuadTree >> inspectorTreeBuilderContext: aContext [
   aContext withoutEvaluator
]
