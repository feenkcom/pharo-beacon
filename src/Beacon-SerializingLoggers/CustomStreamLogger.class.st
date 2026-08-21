"
Example:
	String streamContents: [ :stream |
		(CustomStreamLogger with: stream)
			runDuring: [ 
				StringSignal emit: 'This is a message'.
				StringSignal emit: 'The red fox jumps over the lazy dog'.
				 ] ]
"
Class {
	#name : #CustomStreamLogger,
	#superclass : #StreamLogger,
	#instVars : [
		'stream'
	],
	#category : #'Beacon-SerializingLoggers'
}

{ #category : #'instance creation' }
CustomStreamLogger class >> with: aStream [
	^ self new stream: aStream
]

{ #category : #'initialize-release' }
CustomStreamLogger >> close [
	"Close the receivers stream if it is open"

	mutex critical: 
		[ stream ifNotNil: [ 
			stream close.
			stream := nil. ] ].
]

{ #category : #actions }
CustomStreamLogger >> flushLog [

	mutex critical:
		[ stream ifNotNil: [ stream flush ] ]
]

{ #category : #accessing }
CustomStreamLogger >> nextPutSerialized: anObject [
	"Add a linefeed so that we can get a readable string"

	mutex critical: 
		[ self stream 
			nextPutAll: anObject;
			nextPut: Character lf ]
]

{ #category : #registering }
CustomStreamLogger >> stop [ 

	super stop.
	self close.
]

{ #category : #accessing }
CustomStreamLogger >> stream [
	^ stream
]

{ #category : #accessing }
CustomStreamLogger >> stream: aStream [
	stream := aStream
]
