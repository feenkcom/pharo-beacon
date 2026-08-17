"
This is an abstract logger that forwards to a stream all signals that it receives.
"
Class {
	#name : #StreamLogger,
	#superclass : #SerializingLogger,
	#instVars : [
		'mutex'
	],
	#category : #'Beacon-SerializingLoggers'
}

{ #category : #initialization }
StreamLogger >> initialize [

	super initialize.
	mutex := Mutex new.
]

{ #category : #operations }
StreamLogger >> nextPutSerialized: anObject [

	mutex critical:
		[ self stream nextPutAll: anObject ]
]

{ #category : #registering }
StreamLogger >> stop [

	super stop.
	self flushLog.
]

{ #category : #accessing }
StreamLogger >> stream [
	^ self subclassResponsibility 
]
