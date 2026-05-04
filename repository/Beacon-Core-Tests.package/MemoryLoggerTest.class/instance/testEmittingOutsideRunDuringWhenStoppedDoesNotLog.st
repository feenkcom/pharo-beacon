testing
testEmittingOutsideRunDuringWhenStoppedDoesNotLog

	| logger |
	logger := MemoryLogger new.
	logger stop.
	logger runDuring: [ 'should be in the log' asBeaconSignal emit ].
	'Should not be in the log' asBeaconSignal emit.
	self assert: logger entryCount equals: 1