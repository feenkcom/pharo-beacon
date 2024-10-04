accessing
nextPutSerialized: anObject

	mutex critical:
		[ super nextPutSerialized: anObject.
		flush ifTrue: [ self stream flush ] ].