Class {
	#name : #CTOriginAtBottomLeftInteraction,
	#superclass : #RSInteraction,
	#category : #'QuadTree-UI'
}

{ #category : #hooks }
CTOriginAtBottomLeftInteraction >> onShape: aCanvas [
	aCanvas when: RSExtentChangedEvent send: #updateOriginPosition: to: self
]

{ #category : #hooks }
CTOriginAtBottomLeftInteraction >> updateOriginPosition: evt [
	| canvas camera extent |
	canvas := evt canvas.
	extent := canvas extent.
	camera := evt camera.
	"(width / 2) @ (height / -2) "
	"negative for the height would be to have the zero bottom left"
	camera position: extent / ( 2@ 2).
	"camera zoomToFit: extent. better doing it via another interaction"
	canvas signalUpdate
]
