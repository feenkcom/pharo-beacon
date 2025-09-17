initialization
close
	"Close the receivers stream if it is open"

	mutex critical: 
		[ self stream ifNotNil: [ :theStream |
			theStream closed ifFalse: [ theStream close ].
			stream := nil. ] ].