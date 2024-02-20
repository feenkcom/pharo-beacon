instance creation
stdout 
	"Create an instance of the receiver on stdout"

	instance ifNotNil:
		[ self error: 'RestartingStreamLogger instance already set' ].
	^ self instance stdout