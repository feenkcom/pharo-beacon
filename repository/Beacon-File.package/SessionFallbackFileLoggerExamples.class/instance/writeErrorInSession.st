examples
writeErrorInSession
	"Trigger an error writing the file in the original session.
	The first message should be written to the original log, 
	the second message written to the fallback log."

	<gtExample>
	<return: #SessionFallbackFileLoggerExamples>
	self newLogger.	"We're closing the stream under the logger,
	which will cause the #stop to fail in #runFor:during:."
	logger
		runFor: StringSignal
		during: [ StringSignal emit: 'successful message'.
			logger flushLog.
			logger stream close.	"Writing to a closed stream may not fail until flushed"
			StringSignal emit: 'failed message'.
			logger flushLog ].
	logger close.
	self assert: (fileReference contents trimRight endsWith: 'successful message').
	self assert: (fallbackReference contents trimRight endsWith: 'failed message')