"
This signal is useful to log an exception.

Example:
	TranscriptLogger new runDuring: [
		[1/0] on: Error do: [ :error |  error emit].
	]. 
"
Class {
	#name : #ExceptionSignal,
	#superclass : #ThisContextSignal,
	#instVars : [
		'exception',
		'exceptionStack'
	],
	#category : #'Beacon-ExtraSignals'
}

{ #category : #'instance creation' }
ExceptionSignal class >> emit: anException [
	^ self new
		exception: anException;
		emit
]

{ #category : #testing }
ExceptionSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #'instance creation' }
ExceptionSignal class >> log: anException [
	self deprecated: 'Should use #emit:'.
	^ self emit: anException
]

{ #category : #initialize }
ExceptionSignal >> currentExceptionStack [
	^ exception signalContext
		ifNotNil: [ :aContext | aContext stack collect: #copy ]
		ifNil: [ #() ].
]

{ #category : #initialize }
ExceptionSignal >> currentStack [
	^ self relevantStackWithoutSelf
]

{ #category : #accessing }
ExceptionSignal >> exception [
	^ exception
]

{ #category : #accessing }
ExceptionSignal >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
ExceptionSignal >> exceptionStack [
	^ exceptionStack ifNil: [ exceptionStack := self currentExceptionStack ]
]

{ #category : #initialize }
ExceptionSignal >> prepareForDelivery [
	"I only store the stack when a concrete logger is interested in me"

	super prepareForDelivery.
	self exceptionStack.
]

{ #category : #printing }
ExceptionSignal >> printOn: stream [
	super printOn: stream.
	stream space.
	self exception printOn: stream 
]

{ #category : #printing }
ExceptionSignal >> printOneLineContentsOn: stream [
	self exception printOn: stream 
]
