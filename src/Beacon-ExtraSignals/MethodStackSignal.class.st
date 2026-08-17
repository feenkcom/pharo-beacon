"
This signal only stores the RingMethodDefinition and like that it does not hold the real entire stack. This is safer and smaller to store and serialize.

Usage:
	MethodStackSignal emit
	
Full Example:
	TranscriptLogger new 
		runDuring: [ MethodStackSignal emit ].

"
Class {
	#name : #MethodStackSignal,
	#superclass : #ThisContextSignal,
	#category : #'Beacon-ExtraSignals'
}

{ #category : #'as yet unclassified' }
MethodStackSignal class >> fromStonDictionary: aDictionary [
	^ (super fromStonDictionary: aDictionary)
		basicStack: (aDictionary at: #stack);
		yourself
]

{ #category : #converting }
MethodStackSignal >> asDictionary [
	^ super asDictionary
		at: #stack put: stack;
		yourself
]

{ #category : #initialize }
MethodStackSignal >> currentStack [
	^ self relevantStackWithoutSelf collect: [ :each | 
		each blocDefiningMethod asRingDefinition ]
]

{ #category : #'as yet unclassified' }
MethodStackSignal >> gtStackFor: aView [

	^ aView tree
		title: 'Stack';
		items: [ self stack ];
		priority: 15;
		children: [ :anItem | #() ];
		itemText: [ :anItem | 
			anItem name asRopedText
						append: anItem printString asRopedText ];
		send: [ :anItem | anItem isContext ifTrue: [ anItem ] ifFalse: [ anItem value ] ]
]
