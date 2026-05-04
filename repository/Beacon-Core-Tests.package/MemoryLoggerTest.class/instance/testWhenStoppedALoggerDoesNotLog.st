testing
testWhenStoppedALoggerDoesNotLog
	| logger |
	logger := MemoryLogger new.
	self deny: logger hasEntries.
	logger stop. 
	'Should not be in the log' asBeaconSignal emit.
	self deny: logger hasEntries