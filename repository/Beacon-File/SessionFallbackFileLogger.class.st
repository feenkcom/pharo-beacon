"
SessionFallbackFileLogger writes signals to the specified file.  However, if an error occurs after the session has changed, i.e. the image has been restarted, instead of raising an exception, the log is redirected to the fallback stream.

This handles the case where a logger is being used in an image, the image is then saved and opened in other processes which shouldn't access the log file of the original process.
"
Class {
	#name : #SessionFallbackFileLogger,
	#superclass : #FileLogger,
	#instVars : [
		'fallbackStreamBlock',
		'usingFallback',
		'sessionId'
	],
	#category : #'Beacon-File-Loggers'
}

{ #category : #accessing }
SessionFallbackFileLogger >> fallbackStreamBlock [
	^ fallbackStreamBlock
]

{ #category : #accessing }
SessionFallbackFileLogger >> fallbackStreamBlock: aBlockClosure [
	"Set the block that will create the fallback stream.
	The block is responsible for setting the encoding on the stream (typically UTF-8)."

	fallbackStreamBlock := aBlockClosure
]

{ #category : #actions }
SessionFallbackFileLogger >> flushLog [

	[ super flushLog ]
		on: FileWriteError, PrimitiveFailed
		do: [ :ex |
			usingFallback ifTrue:
				[ ex pass ]
			ifFalse:
				[ | bufferedStream unwritten |
				"Recover the unwritten portion of the current stream, switch to the fallback stream and write the buffer"
				bufferedStream := self stream wrappedStream.
				"Copy the unwritten portion of the buffer.
				Ignore the trailing line feed."
				unwritten := bufferedStream buffer copyFrom: 1 to: bufferedStream bufferPosition - 1.
				self useFallbackStream.
				self nextPutSerialized: unwritten utf8Decoded.
				super flushLog. ] ]
]

{ #category : #initialization }
SessionFallbackFileLogger >> initialize [

	super initialize.
	usingFallback := false.
	fallbackStreamBlock := [ Stdio stdout ].
	self setSessionId.
]

{ #category : #accessing }
SessionFallbackFileLogger >> nextPutSerialized: aString [
	| retried |

	"Try and catch the change of session early otherwise messages may be lost to buffering"
	(stream isNotNil and:
	[ usingFallback not and: 
	[ SessionManager default currentSession id ~= sessionId ] ]) ifTrue:
		[ self useFallbackStream ].
	retried := false.

	[ super nextPutSerialized: aString ]
		on: Error
		do: [ :ex |
			(retried or: [ SessionManager default currentSession id = sessionId ]) ifTrue: 
				[ ex pass ].
			retried := true.
			self useFallbackStream.
			ex retry ].
]

{ #category : #private }
SessionFallbackFileLogger >> privateSessionId: aString [
	"Set the session id.
	Only for testing purposes."
	
	sessionId := aString
]

{ #category : #private }
SessionFallbackFileLogger >> sessionId [
	"Answer the session id.
	Only for testing purposes."
	
	^ sessionId.
]

{ #category : #private }
SessionFallbackFileLogger >> setSessionId [

	sessionId := SessionManager default currentSession id
]

{ #category : #accessing }
SessionFallbackFileLogger >> stream [
	^ super stream value
]

{ #category : #private }
SessionFallbackFileLogger >> useFallbackStream [
	"Switch to the fallback stream.
	Note that the stream in this case can be a BlockClosure as #stream always gets the value.
	This means that the handle for the Stdio stream is not stored, allowing it to survive session restarts."

	usingFallback ifTrue: [ ^ self ].
	
	"Make a best attempt at closing the stream.
	If we've moved to another machine, the path may not exist, so ignore failures."
	mutex critical:
		[ [ self stream close ] on: Error do: [ :ex | ].
		usingFallback := true.
		stream := fallbackStreamBlock. ].
]
