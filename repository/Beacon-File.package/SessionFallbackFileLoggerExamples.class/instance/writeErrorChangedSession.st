examples
writeErrorChangedSession
	"Trigger an error writing the file in a different session"
	<gtExample>
	| fallbackStream |

	fallbackStream := String new writeStream.
	self newLogger.
	logger fallbackStreamBlock: [ fallbackStream ].
	"We're closing the stream under the logger,
	which will cause the #stop to fail in #runFor:during:."
	[ logger runFor: StringSignal during:
		[ StringSignal emit: 'successful message'.
		logger flushLog.
		logger privateSessionId: 'different'.
		logger stream close.
		StringSignal emit: 'fallback message'. 
		logger flushLog ] ]
			on: FileWriteError
			do: [ :ex | "ignore" ].
	logger close.
	self assert: (fileReference contents trimRight endsWith: 'successful message').
	self assert: (fallbackStream contents trimRight endsWith: 'fallback message').