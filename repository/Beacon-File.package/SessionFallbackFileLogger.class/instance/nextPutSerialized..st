accessing
nextPutSerialized: aString
	| retried |

	"Try and catch the change of session early otherwise messages may be lost to buffering"
	(stream isNotNil and:
	[ usingFallback not and: 
	[ SessionManager default currentSession id ~= sessionId ] ]) ifTrue:
		[ self useFallbackStream ].
	retried := false.

	[ super nextPutSerialized: aString ]
		on: Error
		do: [ :ex |
			(retried or: [ SessionManager default currentSession id = sessionId ]) ifTrue: 
				[ ex pass ].
			retried := true.
			self useFallbackStream.
			ex retry ].