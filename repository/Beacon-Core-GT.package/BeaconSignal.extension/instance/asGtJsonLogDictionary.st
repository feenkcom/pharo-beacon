*Beacon-Core-GT
asGtJsonLogDictionary
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