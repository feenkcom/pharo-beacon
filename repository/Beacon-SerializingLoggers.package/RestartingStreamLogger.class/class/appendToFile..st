instance creation
appendToFile: aFileReference
	"Create an instance of the receiver on the supplied file"

	instance
		ifNotNil: [ self error: 'RestartingStreamLogger instance already set' ].
	^ self instance appendToFile: aFileReference