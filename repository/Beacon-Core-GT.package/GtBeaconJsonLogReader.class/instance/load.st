as yet unclassified
load
	| newSignals |

	filename asFileReference readStreamDo: [ :stream |
		stream encoder: ZnLossyUTF8Encoder new.
		newSignals := OrderedCollection new.
		[ [ stream atEnd ] whileFalse:
			[ self processLine: stream nextLine into: newSignals ] ]
				on: NeoJSONParseError
				do: [ :ex | self checkReadError: ex in: stream ] ].
	^ newSignals