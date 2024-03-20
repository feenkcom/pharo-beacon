start - stop
start

	state = #running ifTrue: [ ^ self ].

	task := TaskAtQueueTask
		valuable: [ self flushAndReschedule ]
		at: DateAndTime now + interval
		entryIdentifier: self.
	TaskAtQueue  schedule: task.
	state := #running.