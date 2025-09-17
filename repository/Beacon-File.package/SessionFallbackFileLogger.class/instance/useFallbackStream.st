private
useFallbackStream
	"Switch to the fallback stream.
	Note that the stream in this case can be a BlockClosure as #stream always gets the value.
	This means that the handle for the Stdio stream is not stored, allowing it to survive session restarts."

	usingFallback ifTrue: [ ^ self ].
	
	"Make a best attempt at closing the stream.
	If we've moved to another machine, the path may not exist, so ignore failures."
	mutex critical:
		[ [ self stream close ] on: Error do: [ :ex | ].
		usingFallback := true.
		stream := fallbackStreamBlock. ].