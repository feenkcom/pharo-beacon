accessing
nextPutSerialized: aString

	mutex critical:
		[ super nextPutSerialized: aString.
		self stream nextPut: self lineSeparator. ].