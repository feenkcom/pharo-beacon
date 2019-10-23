accessing
nextPutSerialized: anObject

	super nextPutSerialized: anObject.
	flush ifTrue: [ self stream flush ].