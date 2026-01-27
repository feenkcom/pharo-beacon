as yet unclassified
processLine: aString into: aCollection
	| trimmedString |

	aString ifNil: [ ^ self ].
	trimmedString := aString trimLeft.
	trimmedString ifEmpty: [ ^ self ].
	^ (trimmedString first = ${)
		ifTrue: [ self processJsonLine: aString into: aCollection ]
		ifFalse: [ self processPipeSeparatedLine: aString into: aCollection ]