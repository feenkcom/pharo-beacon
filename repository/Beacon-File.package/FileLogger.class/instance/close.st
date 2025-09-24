initialization
close
	"Close the receivers stream if it is open"

	mutex critical: [ self stream ifNotNil: [ :theStream | 
		(self isStdioStream: theStream) ifFalse:
			[ theStream closed ifFalse: 
				[ theStream close ].
				stream := nil ] ] ]