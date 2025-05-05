examples
fallbackToStdout
	"Trigger an error writing the file in the original session.
	The first message should be written to the original log, 
	the second message written should succeed (but can't be checked.
	This is because opening the fallback stream can't attempt to set the encoder, as is done with the primary stream."

	<gtExample>
	<return: #SessionFallbackFileLoggerExamples>
	| root |
	self assert: logger isNil.
	root := FileSystem memory root.
	fileReference := root / 'log.log'.
	logger := SessionFallbackFileLogger new
			filename: fileReference;
			fallbackStreamBlock: [ Stdio stdout ].	"We're closing the stream under the logger,
	which will cause the #stop to fail in #runFor:during:."
	logger
		runFor: StringSignal
		during: [ StringSignal emit: 'successful message'.
			logger flushLog.
			logger stream close.	"Writing to a closed stream may not fail until flushed"
			StringSignal emit: 'failed message'.
			logger flushLog ].
	logger close.
	self assert: (fileReference contents trimRight endsWith: 'successful message')