private
processLeJsonLine: aString into: aCollection
	| signal |

	signal := LeJsonV4 uniqueInstance deserialize: aString readStream.
	aCollection add: signal.
	^ signal.