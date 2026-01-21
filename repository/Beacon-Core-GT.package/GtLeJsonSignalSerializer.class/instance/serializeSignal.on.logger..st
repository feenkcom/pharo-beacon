serializing
serializeSignal: aSignal on: aStream logger: aLogger 
	| serialized |

	serialized := [ LeJsonV4 uniqueInstance serialize: aSignal ]
		on: Error
		do: [ :ex | | errorSignal |
			errorSignal := GtBeaconLeJsonEncodingErrorSignal new
				message: aSignal printOneLineString;
				timestamp: aSignal timestamp;
				encodingError: ex printString;
				yourself.
			LeJsonV4 uniqueInstance serialize: errorSignal ].
	aStream nextPutAll: serialized.