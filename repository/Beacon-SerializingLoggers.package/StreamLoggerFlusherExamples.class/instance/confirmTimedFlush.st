accessing
confirmTimedFlush
	"Confirm that a stream logger without flushing and with the StreamLoggerFlusher is correctly flushed"
	<gtExample>
	| logFile logger flusher |

	logFile := FileReference newTempFilePrefix: 'StreamLoggerFlusherExamples' suffix: '.log'.
	[ logger := RestartingStreamLogger new
		flush: false;
		streamBlock: [ logFile writeStream ].
	flusher := StreamLoggerFlusher new
		interval: 1 second;
		logger: logger;
		startFor: StringSignal.
	StringSignal emit: '0123456789'.
	self assert: logFile size equals: 0.
	1.5 seconds wait.
	self assert: logFile size > 50 ]
		ensure: 
			[ flusher stop ].
	logFile delete.