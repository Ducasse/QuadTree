Class {
	#name : #CTRegionQuadTreeTest,
	#superclass : #TestCase,
	#category : #QuadTree
}

{ #category : #tests }
CTRegionQuadTreeTest >> quadTreeClass [

	^ CTRegionQuadTree
]

{ #category : #'tests - adding' }
CTRegionQuadTreeTest >> testAddFourElementsWithTwoInTopRightHenceSplittingTwoTimes [

	| tree point point2 point3 point4 |
	tree := self quadTreeClass new.
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	point2 := CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	point3 := CTQuadPoint x: 62 y: 77 object: 'Toronto'.
	point4 := CTQuadPoint x: 82 y: 65 object: 'Buffalo'.
	tree add: point.
	self assert: tree hasData.
	tree add: point2.
	self deny: tree hasData.
	tree add: point3.
	self deny: tree isLeaf.
	self deny: tree hasData.
	tree add: point4.

	self assert: tree topLeftNode data equals: point.
	self assert: tree topRightNode data equals: point2.

	self assert: tree bottomRightNode bottomLeftNode data equals: point3.
	self assert: tree bottomRightNode topRightNode data equals: point4
]

{ #category : #'tests - adding' }
CTRegionQuadTreeTest >> testAddOneElement [

	| tree point |
	tree := self quadTreeClass new.
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	tree add: point.
	self assert: tree isLeaf.
	self assert: tree data equals: point.
	self assert: tree bounds equals: (0 @ 0 corner: 100 @ 100)
]

{ #category : #'tests - adding' }
CTRegionQuadTreeTest >> testAddThreeElementsInSeparateQuads [

	| tree point point2 point3 |
	tree := self quadTreeClass new.
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	point2 := CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	point3 := CTQuadPoint x: 62 y: 77 object: 'Toronto'.

	tree add: point.
	self assert: tree hasData.
	tree add: point2.
	self deny: tree hasData.
	tree add: point3.
	self deny: tree isLeaf.
	self deny: tree hasData.

	self assert: tree topLeftNode data equals: point.
	self assert: tree topRightNode data equals: point2.
	self assert: tree bottomRightNode data equals: point3
]

{ #category : #'tests - adding' }
CTRegionQuadTreeTest >> testAddTwoElementsInSameQuads [

	| tree point point2 |
	tree := self quadTreeClass new.
	point := CTQuadPoint x: 10 y: 10 object: 'topleftoftopleft'.
	point2 := CTQuadPoint x: 40 y: 40 object: 'bottomrightoftopleft'.
	tree add: point.
	tree add: point2.
	self deny: tree isLeaf.
	self deny: tree hasData.

	self assert: tree topLeftNode topLeftNode data equals: point.
	self assert: tree topLeftNode bottomRightNode data equals: point2.

	self assert: tree topRightNode isLeaf.
	self deny: tree topRightNode hasData.
	self assert: tree bottomRightNode isLeaf.
	self deny: tree bottomRightNode hasData.
	self assert: tree bottomLeftNode isLeaf.
	self deny: tree bottomLeftNode hasData
]

{ #category : #'tests - adding' }
CTRegionQuadTreeTest >> testAddTwoElementsInSeparateQuads [

	| tree point point2 |
	tree := self quadTreeClass new.
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	point2 := CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	tree add: point.
	tree add: point2.
	self deny: tree isLeaf.
	self deny: tree hasData.

	self assert: tree topLeftNode data equals: point.
	self assert: tree topRightNode data equals: point2
]

{ #category : #'tests - find' }
CTRegionQuadTreeTest >> testElementsWithinDoesNotFindAny [

	| tree point point2 point3 point4 col |
	tree := self quadTreeClass new.
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	point2 := CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	point3 := CTQuadPoint x: 62 y: 77 object: 'Toronto'.
	point4 := CTQuadPoint x: 82 y: 65 object: 'Buffalo'.
	tree add: point.
	tree add: point2.
	tree add: point3.
	tree add: point4.

	col := tree elementsWithin: (10 @ 10 corner: 30 @ 30).
	self assert: col isEmpty
]

{ #category : #'tests - creation' }
CTRegionQuadTreeTest >> testEmptyTree [

	| tree |
	tree := self quadTreeClass new.
	self assert: tree isLeaf.
	self assert: tree bounds equals: (0 @ 0 corner: 100 @ 100)
]

{ #category : #'tests - creation' }
CTRegionQuadTreeTest >> testEmptyTreeOfBounds [

	| tree |
	tree := self quadTreeClass bounds: (0 @ 0 corner: 100 @ 100).
	self assert: tree isLeaf.
	self assert: tree bounds equals: (0 @ 0 corner: 100 @ 100)
]

{ #category : #'tests - creation' }
CTRegionQuadTreeTest >> testEmptyTreeOfExtent [

	| tree |
	tree := self quadTreeClass extent: 100 @ 100.
	self assert: tree isLeaf.
	self assert: tree bounds equals: (0 @ 0 corner: 100 @ 100)
]

{ #category : #'tests - find' }
CTRegionQuadTreeTest >> testFindNodeInAreaOf [
	
	| tree node |
	tree := CTRegionQuadTree fourPoints.
	node := tree findNodeInAreaOf: 54@12.
	self assert: tree topRightNode equals: node
	
]

{ #category : #'tests - find' }
CTRegionQuadTreeTest >> testFindNodeInAreaOfForNestedPoint [
	
	| tree node |
	tree := CTRegionQuadTree fourPoints.
	node := tree findNodeInAreaOf: 63@78.
	self assert: tree bottomRightNode bottomLeftNode equals: node
	
]

{ #category : #'tests - find' }
CTRegionQuadTreeTest >> testFindNodeInAreaOfForNestedPoint2 [
	
	| tree node |
	tree := CTRegionQuadTree eightPoints.
	node := tree findNodeInAreaOf: 28@35.
	self assert: tree topLeftNode bottomRightNode topLeftNode equals: node
	
]

{ #category : #'tests - find' }
CTRegionQuadTreeTest >> testFindNodeInAreaOfForTopLevel [
	
	| tree node |
	tree := CTRegionQuadTree fourPoints.
	node := tree findNodeInAreaOf: 54@12.
	self assert: tree topRightNode equals: node
	
]

{ #category : #tests }
CTRegionQuadTreeTest >> testHeight [

	| tree |
	tree := self quadTreeClass bounds: (0 @ 0 corner: 100 @ 200).
	self assert: tree height equals: 200
]

{ #category : #'tests - split' }
CTRegionQuadTreeTest >> testNumberOfNodes [

	| tree point point2 point3 point4 |
	tree := self quadTreeClass new.
	point := CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	point2 := CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	point3 := CTQuadPoint x: 62 y: 77 object: 'Toronto'.
	point4 := CTQuadPoint x: 82 y: 65 object: 'Buffalo'.
	tree add: point.
	tree add: point2.
	tree add: point3.
	tree add: point4.
	
	self assert: tree numberOfNodes equals: 7
]

{ #category : #'tests - quadrant' }
CTRegionQuadTreeTest >> testQuadrantOfPointBottomLeft [

	| tree q |
	tree := self quadTreeClass new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 2 y: 72 object: 'Chicago').
	self assert: q equals: tree bottomLeftNode
]

{ #category : #'tests - quadrant' }
CTRegionQuadTreeTest >> testQuadrantOfPointBottomRight [

	| tree q |
	tree := self quadTreeClass new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 72 y: 52 object: 'Chicago').
	self assert: q equals: tree bottomRightNode
]

{ #category : #'tests - quadrant' }
CTRegionQuadTreeTest >> testQuadrantOfPointTopLeft [

	| tree q |
	tree := self quadTreeClass new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 2 y: 2 object: 'Chicago').
	self assert: q equals: tree topLeftNode
]

{ #category : #'tests - quadrant' }
CTRegionQuadTreeTest >> testQuadrantOfPointTopRight [

	| tree q |
	tree := self quadTreeClass new.
	tree split.
	q := tree quadrantOf: (CTQuadPoint x: 72 y: 2 object: 'Chicago').
	self assert: q equals: tree topRightNode
]

{ #category : #'tests - traversal ' }
CTRegionQuadTreeTest >> testSevenTraversal [
	" Pay attention Seven if the number of nodes, not the number of points since some nodes can be empty!"
	| col tree |
	tree := self quadTreeClass new.
	{  CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	CTQuadPoint x: 62 y: 77 object: 'Toronto'.
	CTQuadPoint x: 82 y: 65 object: 'Buffalo'}  do: [ :each | tree add: each ]. 
	col := OrderedCollection new. 
	tree do: [ :each | col add: each ].
	self assert: col size equals: 7.
	
]

{ #category : #'tests - traversal ' }
CTRegionQuadTreeTest >> testSevenTraversalWithData [
	" Pay attention Seven if the number of nodes, not the number of points since some nodes can be empty!"
	| col tree |
	tree := self quadTreeClass new.
	{  CTQuadPoint x: 35 y: 42 object: 'Chicago'.
	CTQuadPoint x: 52 y: 10 object: 'Mobile'.
	CTQuadPoint x: 62 y: 77 object: 'Toronto'.
	CTQuadPoint x: 82 y: 65 object: 'Buffalo'}  do: [ :each | tree add: each ]. 
	col := OrderedCollection new. 
	tree do: [ :each | each hasData ifTrue: [ col add: each data x @ each data y ]].
		
	self assert: col asArray equals: { 35@42 . 52@10 .  82@65 . 62@77 }
]

{ #category : #'tests - split' }
CTRegionQuadTreeTest >> testSplitGemeotry [

	| tree |
	tree := self quadTreeClass new.
	tree split.
	self assert: tree topLeftNode bounds equals: (0 @ 0 corner: 50 @ 50).
	self
		assert: tree topRightNode bounds
		equals: (50 @ 0 corner: 100 @ 50).
	self
		assert: tree bottomLeftNode bounds
		equals: (0 @ 50 corner: 50 @ 100).
	self
		assert: tree bottomRightNode bounds
		equals: (50 @ 50 corner: 100 @ 100)
]

{ #category : #'tests - split' }
CTRegionQuadTreeTest >> testSplitInstantiates4Children [

	| tree |
	tree := self quadTreeClass new.
	tree split.
	self deny: tree isLeaf.
	self assert: tree children size equals: 4
]

{ #category : #'tests - traversal ' }
CTRegionQuadTreeTest >> testTreePointsTraversal [

	| col | 
	col := OrderedCollection new. 
	self quadTreeClass troisPoints do: [ :each | col add: each ].
	self assert: col size equals: 4.
	
]

{ #category : #tests }
CTRegionQuadTreeTest >> testWidth [

	| tree |
	tree := self quadTreeClass bounds: (0 @ 0 corner: 100 @ 200).
	self assert: tree width equals: 100
]
