accessing
nextPutSerialized: anObject
	"Add a linefeed so that we can get a readable string"

	mutex critical: 
		[ self stream 
			nextPutAll: anObject;
			nextPut: Character lf ]