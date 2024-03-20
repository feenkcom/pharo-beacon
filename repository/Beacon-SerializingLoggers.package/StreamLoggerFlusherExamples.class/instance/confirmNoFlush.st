accessing
confirmNoFlush
	"Confirm that a stream logger without flushing doesn't in fact get written quickly"
	<gtExample>
	| logFile logger |

	logFile := FileReference newTempFilePrefix: 'StreamLoggerFlusherExamples' suffix: '.log'.
	[ logger := RestartingStreamLogger new
		flush: false;
		streamBlock: [ logFile writeStream ];
		startFor: StringSignal.
	100 timesRepeat: [ StringSignal emit: '0123456789' ].
	self assert: logFile size equals: 0 ]
		ensure: [ logger stop ].
	self assert: logFile size > 5000.
	logFile delete.