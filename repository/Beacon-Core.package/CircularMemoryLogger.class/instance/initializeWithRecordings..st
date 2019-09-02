initialization
initializeWithRecordings: aCollection

	super initializeWithRecordings: aCollection.
	entryCount := aCollection size.
	fullBuffer := true.