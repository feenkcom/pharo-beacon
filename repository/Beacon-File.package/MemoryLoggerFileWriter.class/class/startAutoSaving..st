saving
startAutoSaving: aLogger
	"Write the default instance to a file every WritePeriod"

	WriteProcess ifNotNil: [ self error: 'Write process already running' ].

	WriteProcess := [ self writeLoop: aLogger ]
		forkAt: Processor userInterruptPriority
		named: aLogger class name, ' auto-save'.