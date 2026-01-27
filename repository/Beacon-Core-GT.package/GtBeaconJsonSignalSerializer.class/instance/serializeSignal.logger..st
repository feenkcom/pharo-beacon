serializing
serializeSignal: aSignal logger: aLogger 

	^ String streamContents: [ :stream |
		self serializeSignal: aSignal on: stream logger: aLogger ].