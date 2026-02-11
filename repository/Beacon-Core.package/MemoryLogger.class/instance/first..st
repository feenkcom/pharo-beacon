enumerating
first: anInteger
	"Answer a new instance of the receiver with only the requested signals"

	^(self class withRecordings: (self recordings first: anInteger))
		name: 'First: ', anInteger asString.