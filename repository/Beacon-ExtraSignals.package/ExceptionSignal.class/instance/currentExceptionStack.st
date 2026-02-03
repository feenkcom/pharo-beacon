initialize
currentExceptionStack
	^ exception signalContext
		ifNotNil: [ :aContext | aContext stack collect: #copy ]
		ifNil: [ #() ].