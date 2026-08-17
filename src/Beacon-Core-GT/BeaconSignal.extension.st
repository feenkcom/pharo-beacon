Extension { #name : #BeaconSignal }

{ #category : #'*Beacon-Core-GT' }
BeaconSignal >> asGtJsonLogDictionary [
	| jsonDictionary oneLineContent timestampString |

	jsonDictionary := Dictionary new.
	properties ifNotEmpty: 
		[ | jsonProperties |
		jsonProperties := (properties associations collect: [ :assoc |
			assoc key asString -> assoc value asString ])
				asDictionary.
		jsonDictionary at: 'properties' put: jsonProperties ].
	oneLineContent := String streamContents: [ :stream |
		self printOneLineContentsOn: stream ].
	timestampString := [ timestamp iso8601 ]
			on: Error
			do: [ :ex | timestamp asString ].
	jsonDictionary
		at: 'signalClass' put: self class name;
		at: 'timestamp' put: timestampString;
		at: 'processId' put: processId asString;
		at: 'message' put: oneLineContent.
	^ jsonDictionary
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal class >> fromGtJsonDictionary: aDictionary [
	| instance message timestamp |

	timestamp := DateAndTime readFrom: (aDictionary at: #timestamp) readStream.
	instance := self new
			basicTimestamp: timestamp;
			basicProcessId: (aDictionary at: #processId);
			basicProperties: (aDictionary at: #properties ifAbsent: [ Dictionary new ]);
			yourself.

	[ message := aDictionary at: 'message'.
	message first = $| ifTrue:
		[ message := message allButFirst trimBoth ].
	(message includesSubstring: ' | ') ifTrue:
		[ instance 
			initializeFromTimestamp: timestamp 
			andData: (message splitOn: ' | ') ]
	ifFalse:
		[ instance properties at: 'message' put: message ]. ]
			on: Error
			do: [ :ex |
				instance properties
					at: 'message' put: message asString;
					at: 'messageProcessingError' put: ex ].
	^ instance.
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal >> gtDisplayOn: stream [
	self printOneLineOn: stream
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal class >> gtExampleEmpty [
	<gtExample>
	<label: 'Empty'>
	
	^ self new
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal >> gtLogSeverity [
	"Answer the receiver's severity.
	This is for compatibility with generic log readers.
	One of TRACE, DEBUG, INFO, WARN, ERROR, FATAL"
	
	^ 'INFO'
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal >> gtOneLineIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite text
		title: 'One line';
		display: [ self printOneLineString ]
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal >> processId: aString [

	processId := aString
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal >> properties: aDictionary [

	properties := aDictionary
]

{ #category : #'*Beacon-Core-GT' }
BeaconSignal >> timestamp: aDateAndTime [

	timestamp := aDateAndTime
]
