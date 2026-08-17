"
GtRrRunnerLogReader reads a log file typically created by a headless remote runner and loads signals that respond to `#initializeFromTimestamp:andData:`.

```
GtRrRunnerLogReader new
	filename: 'remoteRunner.log';
	load
```
"
Class {
	#name : #GtBeaconJsonLogReader,
	#superclass : #Object,
	#instVars : [
		'filename',
		'signals',
		'strictMode'
	],
	#category : #'Beacon-Core-GT-Analysis'
}

{ #category : #'as yet unclassified' }
GtBeaconJsonLogReader >> checkReadError: anException in: aStream [
	"If the stream is large enough and near the end, assume that it is still open and being written to, in which case we can just use the records already read."

	(aStream size > 4096 and: [ (aStream position / aStream size) > 0.95 ]) ifTrue: [ ^ self ].
	self error: 'Unexpected error while reading log'.
]

{ #category : #accessing }
GtBeaconJsonLogReader >> contents [

	^ filename contents
]

{ #category : #accessing }
GtBeaconJsonLogReader >> filename [
	^ filename
]

{ #category : #accessing }
GtBeaconJsonLogReader >> filename: anObject [
	filename := anObject
]

{ #category : #accessing }
GtBeaconJsonLogReader >> gtSignalsFor: aView [
	<gtView>

	^ aView forward
		title: 'Signals';
		priority: 10;
		object: [ self memoryLogger ];
		view: #gtRecordingsFor:
]

{ #category : #initialization }
GtBeaconJsonLogReader >> initialize [

	super initialize.
	strictMode := true.
]

{ #category : #'as yet unclassified' }
GtBeaconJsonLogReader >> load [
	| newSignals |

	filename asFileReference readStreamDo: [ :stream |
		stream encoder: ZnLossyUTF8Encoder new.
		newSignals := OrderedCollection new.
		[ [ stream atEnd ] whileFalse:
			[ self processLine: stream nextLine into: newSignals ] ]
				on: NeoJSONParseError
				do: [ :ex | self checkReadError: ex in: stream ] ].
	^ newSignals
]

{ #category : #accessing }
GtBeaconJsonLogReader >> memoryLogger [
	"Answer a MemoryLogger loaded with the receiver's signals.
	Generally for debugging purposes."

	^ MemoryLogger new
		initializeWithRecordings: self signals.
]

{ #category : #'as yet unclassified' }
GtBeaconJsonLogReader >> processJsonLine: aString into: aCollection [
	| jsonDictionary signalClass signal |

	jsonDictionary := (NeoJSONReader on: aString readStream) next.
	signalClass := self class environment classOrTraitNamed: (jsonDictionary at: 'signalClass') asSymbol.
	signalClass ifNil: [ self error: 'No signal class provided' ].
	[ signal := signalClass fromGtJsonDictionary: jsonDictionary.
	aCollection add: signal. ]
		on: Error
		do: [ :ex | strictMode ifTrue: [ ex pass ] ].
	^ signal.
]

{ #category : #private }
GtBeaconJsonLogReader >> processLeJsonLine: aString into: aCollection [
	| signal |

	signal := LeJsonV4 uniqueInstance deserialize: aString readStream.
	aCollection add: signal.
	^ signal.
]

{ #category : #'as yet unclassified' }
GtBeaconJsonLogReader >> processLine: aString into: aCollection [
	| trimmedString |

	aString ifNil: [ ^ self ].
	trimmedString := aString trimLeft.
	trimmedString ifEmpty: [ ^ self ].
	^ (trimmedString first = ${)
		ifTrue: [ self processJsonLine: aString into: aCollection ]
		ifFalse: [ self processPipeSeparatedLine: aString into: aCollection ]
]

{ #category : #private }
GtBeaconJsonLogReader >> processPipeSeparatedLine: aString [
	| words date cls data signal |

	words := aString splitOn: Character space.
	"Minimum is date, class, signal type"
	words size < 3 ifTrue: [ ^ self ].
	(self shouldLoad: words) ifFalse: [ ^ self ].

	[ date := DateAndTime readFrom: words first readStream ]
		on: Error
		do: [ :ex | ^ self ].
	cls := Smalltalk classOrTraitNamed: words second asSymbol.
	cls ifNil: [ ^ self ].
	(cls canUnderstand: #initializeFromTimestamp:andData:) ifFalse: [ ^ self ].
	(self shouldLoad: words) ifFalse: [ ^ self ].

	data := (aString splitOn: ' | ') allButFirst.
	[ signals add: (signal := cls new initializeFromTimestamp: date andData: data) ]
		on: Error
		do: [ :ex | strictMode ifTrue: [ ex pass ] ].
	^ signal
]

{ #category : #private }
GtBeaconJsonLogReader >> processPipeSeparatedLine: aString into: aCollection [
	| words date cls data signal |

	words := aString splitOn: Character space.
	"Minimum is date, class, signal type"
	words size < 3 ifTrue: [ ^ self ].
	(self shouldLoad: words) ifFalse: [ ^ self ].

	[ date := DateAndTime readFrom: words first readStream ]
		on: Error
		do: [ :ex | ^ self ].
	cls := Smalltalk classOrTraitNamed: words second asSymbol.
	cls ifNil: [ ^ self ].
	(cls canUnderstand: #initializeFromTimestamp:andData:) ifFalse: [ ^ self ].
	(self shouldLoad: words) ifFalse: [ ^ self ].

	data := (aString splitOn: ' | ') allButFirst.
	[ aCollection add: (signal := cls new initializeFromTimestamp: date andData: data) ]
		on: Error
		do: [ :ex | strictMode ifTrue: [ ex pass ] ].
	^ signal
]

{ #category : #private }
GtBeaconJsonLogReader >> shouldLoad: words [
	"Give subclasses a chance to add criteria"
	
	^ true
]

{ #category : #accessing }
GtBeaconJsonLogReader >> signals [

	^ signals ifNil: [ signals := self load ].
]

{ #category : #accessing }
GtBeaconJsonLogReader >> strictMode [
	^ strictMode
]

{ #category : #accessing }
GtBeaconJsonLogReader >> strictMode: anObject [
	strictMode := anObject
]
