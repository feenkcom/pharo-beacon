accessing
memoryLogger
	"Answer a MemoryLogger loaded with the receiver's signals.
	Generally for debugging purposes."

	^ MemoryLogger new
		basicRecordings: self signals.