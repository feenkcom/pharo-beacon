private
useFallbackStream
	"Switch to the fallback stream"

	usingFallback ifTrue: [ ^ self ].
	
	"Make a best attempt at closing the stream.
	If we've moved to another machine, the path may not exist, so ignore failures."
	mutex critical:
		[ [ stream close ] on: Error do: [ :ex | ex logStackToFile ].
		usingFallback := true.
		stream := fallbackStreamBlock value.
		binary ifFalse:
			[ stream encoder: self encoder ] ].