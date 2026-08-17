Class {
	#name : #GtBeaconJsonSignalSerializer,
	#superclass : #Object,
	#category : #'Beacon-Core-GT-SerializingLoggers'
}

{ #category : #serializing }
GtBeaconJsonSignalSerializer >> serializeSignal: aSignal logger: aLogger [ 

	^ String streamContents: [ :stream |
		self serializeSignal: aSignal on: stream logger: aLogger ].
]

{ #category : #serializing }
GtBeaconJsonSignalSerializer >> serializeSignal: aSignal on: aStream logger: aLogger [ 
	| serialized |

	serialized := [ String streamContents: [ :stream |
			(NeoJSONWriter on: stream)
				prettyPrint: false;
				nextPut: aSignal asGtJsonLogDictionary ] ]
		on: Error
		do: [ :ex |
			NeoJSONWriter toString: {
				'signalClass' -> 'GtBeaconLeJsonEncodingErrorSignal'.
				'message' -> aSignal printOneLineString.
				'timestamp' -> aSignal timestamp iso8601.
				'encodingError' -> ex printString. }
					asDictionary ].
	aStream nextPutAll: serialized.
]
