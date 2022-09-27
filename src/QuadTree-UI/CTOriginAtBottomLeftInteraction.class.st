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
	| canvas camera extent scale |
	canvas := evt canvas.
	extent := canvas extent * 0.95.
	camera := evt camera.
	"(width / 2) @ (height / -2) "
	"negative for the height would be to have the zero bottom left"
	"camera position: extent / ( 2@ 2)."
	scale := (extent / canvas shapes extent) min.
	camera scale: scale.
	camera position: (extent / 2/ scale).
	canvas signalUpdate
]
