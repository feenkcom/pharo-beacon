"
This is a convenience signal to record the stack information from thisContext. The recording happens during the initialization of the instance. This is particularly useful when you need to track the behavior of sensitive methods that do not allow for halting (e.g., a debugger or a rendering method).

See subclasses for concrete implementations
"
Class {
	#name : #ThisContextSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'stack'
	],
	#category : #'Beacon-ExtraSignals'
}

{ #category : #'instance creation' }
ThisContextSignal class >> emit [
	^ self new emit
]

{ #category : #'instance creation' }
ThisContextSignal class >> log [
	self deprecated: 'Should use #emit'.
	^ self emit
]

{ #category : #initialize }
ThisContextSignal >> basicStack: aStack [
	stack := aStack
]

{ #category : #initialize }
ThisContextSignal >> currentStack [
	self subclassResponsibility 
]

{ #category : #initialize }
ThisContextSignal >> prepareForDelivery [
	"I only store the stack when a concrete logger is interested in me"
	self stack
]

{ #category : #printing }
ThisContextSignal >> printOn: stream [
	super printOn: stream.
	self stack do: [ :each |
		stream 
			cr;
			tab; 
			nextPutAll: (
				each asString 
					copyReplaceAll: String cr 
					with: String cr, 
							String tab, 
							String tab) ]
]

{ #category : #printing }
ThisContextSignal >> printOneLineContentsOn: stream [

	self message ifEmpty:
		[ stream nextPutAll: (self stack first asString 
					copyReplaceAll: String cr 
					with: String cr, 
							String tab, 
							String tab) ]
	ifNotEmpty: [ :message | stream nextPutAll: message ].
]

{ #category : #initialize }
ThisContextSignal >> relevantStackWithoutSelf [
	| s |
	s := thisContext stack collect: #copy.
	^ s allButFirst: (s findLast: [ :each | each receiver == self or: [ each receiver == self class ] ])
]

{ #category : #accessing }
ThisContextSignal >> stack [
	^ stack ifNil: [ stack := self currentStack ]
]
