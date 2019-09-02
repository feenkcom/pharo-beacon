enumerating
select: aBlock
	"Answer a new instance of the receiver with only the selected signals"

	^(self class withRecordings: (self recordings select: aBlock))
		name: aBlock printString.