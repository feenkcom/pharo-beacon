examples
confirmExceptionCaught
	"Confirm that an exception during flushing causes the flusher to go in to error state and captures the error."
	<gtExample>
	| logFileStream logger flusher beaconLogger logFile |

	beaconLogger := MemoryLogger new startFor: StreamLoggerFlusherErrorSignal.
	logFile := FileReference newTempFilePrefix: 'StreamLoggerFlusherExamples' suffix: '.log'.
	logFileStream := logFile writeStream.
	[ logger := CustomStreamLogger with: logFileStream.
	"Closing the stream under the logger will cause a primitive failure on flush"
	logFileStream close ]
		ensure: [ logFile ensureDelete ].
	flusher := StreamLoggerFlusher new
		logger: logger;
		interval: 0.1 seconds;
		start.
	1.5 seconds wait.
	beaconLogger stop.
	self assert: flusher state equals: #error.
	self assert: flusher exception class equals: PrimitiveFailed.
	self assert: beaconLogger recordings size equals: 1.