private
processPipeSeparatedLine: aString
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