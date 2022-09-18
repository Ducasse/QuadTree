Extension { #name : #CTRegionQuadTree }

{ #category : #'*QuadTree-UI' }
CTRegionQuadTree >> inspectorTreeBuilder [
    <inspectorPresentationOrder: 1 title: 'Visual'>

	^ QuadTreeVisualizer new
        quadTree: self ;
        asPresenter
]
