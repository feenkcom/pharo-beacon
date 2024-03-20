private
flushAndReschedule

	state = #idle ifTrue: [ ^ self ].
	self flush.
	self reschedule.