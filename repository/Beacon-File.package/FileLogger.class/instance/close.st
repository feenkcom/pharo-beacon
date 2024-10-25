initialization
close
	"Close the receivers stream if it is open"

	mutex critical: 
		[ stream ifNotNil: [ 
			stream closed ifFalse: [ stream close ].
			stream := nil. ] ].