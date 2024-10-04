operations
nextPutSerialized: anObject

	mutex critical:
		[ self stream nextPutAll: anObject ]