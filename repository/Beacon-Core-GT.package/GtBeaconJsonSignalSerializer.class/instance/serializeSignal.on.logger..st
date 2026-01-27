serializing
serializeSignal: aSignal on: aStream logger: aLogger 
	| serialized |

	serialized := [ String streamContents: [ :stream |
			(NeoJSONWriter on: stream)
				prettyPrint: false;
				nextPut: aSignal asGtJsonLogDictionary ] ]
		on: Error
		do: [ :ex | self halt.
			NeoJSONWriter toString: {
				'signalClass' -> 'GtBeaconLeJsonEncodingErrorSignal'.
				'message' -> aSignal printOneLineString.
				'timestamp' -> aSignal timestamp iso8601.
				'encodingError' -> ex printString. }
					asDictionary ].
	aStream nextPutAll: serialized.