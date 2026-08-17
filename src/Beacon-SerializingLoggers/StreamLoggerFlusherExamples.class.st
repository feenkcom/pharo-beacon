Class {
	#name : #StreamLoggerFlusherExamples,
	#superclass : #Object,
	#category : #'Beacon-SerializingLoggers-Examples'
}

{ #category : #examples }
StreamLoggerFlusherExamples >> confirmExceptionCaught [
	"Confirm that an exception during flushing causes the flusher to go in to error state and captures the error."

	<gtExample>
	<return: #StreamLoggerFlusherExamples>
	| logFileStream logger flusher beaconLogger logFile |
	beaconLogger := MemoryLogger new startFor: StreamLoggerFlusherErrorSignal.
	logFile := FileReference
			newTempFilePrefix: 'StreamLoggerFlusherExamples'
			suffix: '.log'.
	logFileStream := logFile writeStream.
	[ logger := CustomStreamLogger with: logFileStream.	"Closing the stream under the logger will cause a primitive failure on flush"
	logFileStream close ] ensure: [ logFile ensureDelete ].
	flusher := StreamLoggerFlusher new
			logger: logger;
			interval: 0.1 seconds;
			start.
	1.5 seconds wait.
	beaconLogger stop.
	self assert: flusher state equals: #error.
	self assert: flusher exception class equals: PrimitiveFailed.
	self assert: beaconLogger recordings size equals: 1
]

{ #category : #accessing }
StreamLoggerFlusherExamples >> confirmNoFlush [
	"Confirm that a stream logger without flushing doesn't in fact get written quickly"

	<gtExample>
	<return: #StreamLoggerFlusherExamples>
	| logFile logger |
	logFile := FileReference
			newTempFilePrefix: 'StreamLoggerFlusherExamples'
			suffix: '.log'.
	[ logger := RestartingStreamLogger new
			flush: false;
			streamBlock: [ logFile writeStream ];
			startFor: StringSignal.
	100 timesRepeat: [ StringSignal emit: '0123456789' ].
	self assert: logFile size equals: 0 ] ensure: [ logger stop ].
	self assert: logFile size > 5000.
	logFile delete
]

{ #category : #accessing }
StreamLoggerFlusherExamples >> confirmTimedFlush [
	"Confirm that a stream logger without flushing and with the StreamLoggerFlusher is correctly flushed"

	<gtExample>
	<return: #StreamLoggerFlusherExamples>
	| logFile logger flusher |
	logFile := FileReference
			newTempFilePrefix: 'StreamLoggerFlusherExamples'
			suffix: '.log'.
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
	self assert: logFile size > 50 ] ensure: [ flusher stop ].
	logFile delete
]
