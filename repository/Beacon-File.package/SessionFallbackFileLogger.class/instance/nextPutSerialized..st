accessing
nextPutSerialized: aString

	"Try and catch the change of session early otherwise messages may be lost to buffering"
	(usingFallback not and: [ SessionManager default currentSession id ~= sessionId ]) ifTrue:
		[ stream close.
		usingFallback := true.
		stream := fallbackStreamBlock value ].

	[ super nextPutSerialized: aString ]
		on: Error
		do: [ :ex |
			(usingFallback or:
				[ SessionManager default currentSession id = sessionId ]) ifTrue: 
					[ ex pass ].
			stream close.
			usingFallback := true.
			stream := fallbackStreamBlock value.
			super nextPutSerialized: aString ].