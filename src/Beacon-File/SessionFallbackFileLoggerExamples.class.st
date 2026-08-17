Class {
	#name : #SessionFallbackFileLoggerExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'logger',
		'fileReference',
		'fallbackReference'
	],
	#category : #'Beacon-File-Examples'
}

{ #category : #examples }
SessionFallbackFileLoggerExamples >> fallbackToStdout [
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
]

{ #category : #examples }
SessionFallbackFileLoggerExamples >> logMessage [
	"Demonstrate successfully logging a message"

	<gtExample>
	<return: #SessionFallbackFileLoggerExamples>
	self newLogger.
	logger runFor: StringSignal during: [ StringSignal emit: 'log message' ].
	logger close.
	self assert: (fileReference contents trimRight endsWith: 'log message').
	self assert: fallbackReference contents isEmpty.
	self assert: logger sessionId = SessionManager default currentSession id
]

{ #category : #private }
SessionFallbackFileLoggerExamples >> newLogger [
	"Answer a new in-memory logger"
	| root fallbackWriteStream |

	self assert: logger isNil.
	root := FileSystem memory root.
	fileReference := root / 'log.log'.
	fallbackReference := root / 'fallback.log'.
	fallbackWriteStream := fallbackReference writeStream.
	logger := SessionFallbackFileLogger new 
		filename: fileReference;
		fallbackStreamBlock: [ fallbackWriteStream ].
]

{ #category : #examples }
SessionFallbackFileLoggerExamples >> writeErrorChangedSession [
	"Trigger an error writing the file in a different session"

	<gtExample>
	<return: #SessionFallbackFileLoggerExamples>
	self newLogger.	"We're closing the stream under the logger,
	which will cause the #stop to fail in #runFor:during:."
	logger
		runFor: StringSignal
		during: [ StringSignal emit: 'successful message'.
			logger flushLog.
			logger privateSessionId: 'different'.
			logger stream close.
			StringSignal emit: 'fallback message'.
			logger flushLog ].
	logger close.
	self assert: (fileReference contents trimRight endsWith: 'successful message').
	self
		assert: (fallbackReference contents trimRight endsWith: 'fallback message')
]

{ #category : #examples }
SessionFallbackFileLoggerExamples >> writeErrorInSession [
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
]
