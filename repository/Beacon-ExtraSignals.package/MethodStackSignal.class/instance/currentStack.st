initialize
currentStack
	^ self relevantStackWithoutSelf collect: [ :each | 
		each blocDefiningMethod asRingDefinition ]