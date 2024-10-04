initialize-release
close
	"Close the receivers stream if it is open"

	mutex critical: 
		[ stream ifNotNil: [ 
			stream close.
			stream := nil. ] ].