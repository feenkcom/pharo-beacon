accessing
nextPutSerialized: aString

	"Try and catch the change of session early otherwise messages may be lost to buffering"
	(stream isNotNil and:
	[ usingFallback not and: 
	[ SessionManager default currentSession id ~= sessionId ] ]) ifTrue:
		[ self useFallbackStream ].

	[ super nextPutSerialized: aString ]
		on: Error
		do: [ :ex |
			SessionManager default currentSession id = sessionId ifTrue: 
				[ ex pass ].
			self useFallbackStream.
			ex retry ].