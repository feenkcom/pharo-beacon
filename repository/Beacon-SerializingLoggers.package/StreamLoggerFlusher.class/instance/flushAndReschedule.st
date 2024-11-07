private
flushAndReschedule

	state = #idle ifTrue: [ ^ self ].
	[ [ self flush.
	self reschedule ]
		on: Error
		do: [ :ex |
			state := #error.
			exception := ex freeze.
			StreamLoggerFlusherErrorSignal signal: self ] ]
		forkAt: Processor userBackgroundPriority 
		named: 'StreamLogger flushAndReschedule'.