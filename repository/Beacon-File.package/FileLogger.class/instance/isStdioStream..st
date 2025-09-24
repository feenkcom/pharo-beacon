testing
isStdioStream: theStream
	| innerStream |

	innerStream := theStream.
	[ innerStream wrappedStream isNil ] whileFalse:
		[ innerStream := innerStream wrappedStream ].
	^ #('stdout' 'stderr') includes: innerStream name