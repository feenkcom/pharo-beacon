testing
isRunning
	"Answer a boolean indicating whether the receiver's default instance is running"
	<return: #Boolean>

	^ instance isNotNil and: [ instance isRunning ]