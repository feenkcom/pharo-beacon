printing
printOn: aStream
	super printOn: aStream.
	aStream 
		nextPut: $(;
		nextPutAll: name asString;
		nextPut: $)