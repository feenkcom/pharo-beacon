*Beacon-Core-GT
fromGtJsonDictionary: aDictionary
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