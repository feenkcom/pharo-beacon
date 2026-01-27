accessing
message
	^ message ifNil: [ self properties at: 'message' ifAbsent: [ '' ] ]