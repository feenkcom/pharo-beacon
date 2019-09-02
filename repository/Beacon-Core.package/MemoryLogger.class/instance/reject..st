enumerating
reject: aBlock
	"Answer a new instance of the receiver with only the selected signals"

	^(self class withRecordings: (self recordings reject: aBlock))
		name: aBlock printString.