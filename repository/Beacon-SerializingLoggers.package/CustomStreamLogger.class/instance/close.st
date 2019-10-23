initialize-release
close
	"Close the receivers stream if it is open"

	stream ifNotNil: [ 
		stream close.
		stream := nil. ].