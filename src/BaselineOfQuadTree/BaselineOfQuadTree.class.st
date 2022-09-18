Class {
	#name : #BaselineOfQuadTree,
	#superclass : #BaselineOf,
	#category : #BaselineOfQuadTree
}

{ #category : #baselines }
BaselineOfQuadTree >> baseline: spec [
	<baseline>
	"in the future we should express dependencies to roassal 3.0"
	spec for: #common do: [
		spec 
			package: #'QuadTree';
			package: #'QuadTree-UI'.
		
		spec 
			group: 'Core' with: #('QuadTree');
			group: 'UI' with: #('QuadTree-UI');
			group: 'default' with: #('Core' 'UI') ].		
	







]
