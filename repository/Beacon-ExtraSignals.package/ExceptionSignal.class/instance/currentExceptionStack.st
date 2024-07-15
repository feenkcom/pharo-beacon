initialize
currentExceptionStack
	^ exception signalerContext stack collect: #copy