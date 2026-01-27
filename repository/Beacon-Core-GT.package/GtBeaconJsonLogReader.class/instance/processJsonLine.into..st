as yet unclassified
processJsonLine: aString into: aCollection
	| jsonDictionary signalClass signal |

	jsonDictionary := (NeoJSONReader on: aString readStream) next.
	signalClass := self class environment classOrTraitNamed: (jsonDictionary at: 'signalClass') asSymbol.
	signalClass ifNil: [ self error: 'No signal class provided' ].
	[ signal := signalClass fromGtJsonDictionary: jsonDictionary.
	aCollection add: signal. ]
		on: Error
		do: [ :ex | strictMode ifTrue: [ ex pass ] ].
	^ signal.