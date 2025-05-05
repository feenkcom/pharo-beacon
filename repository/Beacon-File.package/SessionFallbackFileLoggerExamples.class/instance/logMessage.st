examples
logMessage
	"Demonstrate successfully logging a message"

	<gtExample>
	<return: #SessionFallbackFileLoggerExamples>
	self newLogger.
	logger runFor: StringSignal during: [ StringSignal emit: 'log message' ].
	logger close.
	self assert: (fileReference contents trimRight endsWith: 'log message').
	self deny: fallbackReference exists.
	self assert: logger sessionId = SessionManager default currentSession id