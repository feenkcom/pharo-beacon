Class {
	#name : #StreamLoggerFlusher,
	#superclass : #Object,
	#instVars : [
		'logger',
		'interval',
		'task',
		'state',
		'exception'
	],
	#category : #'Beacon-SerializingLoggers-Flushing'
}

{ #category : #'start - stop' }
StreamLoggerFlusher >> close [

	logger close.
]

{ #category : #accessing }
StreamLoggerFlusher >> exception [
	^ exception
]

{ #category : #accessing }
StreamLoggerFlusher >> fileReference [

	^ logger fileReference
]

{ #category : #private }
StreamLoggerFlusher >> flush [

	logger flushLog
]

{ #category : #private }
StreamLoggerFlusher >> flushAndReschedule [

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
]

{ #category : #accessing }
StreamLoggerFlusher >> flushLog [

	logger flushLog
]

{ #category : #accessing }
StreamLoggerFlusher >> initialize [

	super initialize.
	interval := 15 seconds.
	state := #idle.
]

{ #category : #accessing }
StreamLoggerFlusher >> interval [
	^ interval
]

{ #category : #accessing }
StreamLoggerFlusher >> interval: aDuration [

	interval := aDuration
]

{ #category : #accessing }
StreamLoggerFlusher >> logger [
	^ logger
]

{ #category : #accessing }
StreamLoggerFlusher >> logger: anObject [
	logger := anObject
]

{ #category : #private }
StreamLoggerFlusher >> reschedule [

	task scheduledTime: DateAndTime now + interval.
	TaskAtQueue schedule: task.
]

{ #category : #'start - stop' }
StreamLoggerFlusher >> start [

	state = #running ifTrue: [ ^ self ].

	task := TaskAtQueueTask
		valuable: [ self flushAndReschedule ]
		at: DateAndTime now + interval
		entryIdentifier: self.
	TaskAtQueue  schedule: task.
	state := #running.
]

{ #category : #'api - logger' }
StreamLoggerFlusher >> startFor: announcements [

	logger startFor: announcements.
	self start.
]

{ #category : #accessing }
StreamLoggerFlusher >> state [
	^ state
]

{ #category : #'start - stop' }
StreamLoggerFlusher >> stop [

	state := #idle.
	logger stop.
]
