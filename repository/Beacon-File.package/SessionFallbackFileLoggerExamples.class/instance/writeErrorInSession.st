examples
writeErrorInSession
	"Trigger an error writing the file in the original session"
	<gtExample>

	self newLogger.
	"We're closing the stream under the logger,
	which will cause the #stop to fail in #runFor:during:."
	[ logger runFor: StringSignal during:
		[ StringSignal emit: 'successful message'.
		logger flushLog.
		logger stream close.
		"Writing to a closed stream may not fail until flushed"
		self should: [ StringSignal emit: 'failed message'. logger flushLog ]
			raise: FileWriteError ] ]
				on: FileWriteError
				do: [ :ex | "ignore" ].
	logger close.
	self assert: (fileReference contents trimRight endsWith: 'successful message').