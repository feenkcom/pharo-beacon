Class {
	#name : #NonInteractiveTranscriptLoggerStartUp,
	#superclass : #Object,
	#category : #'Beacon-Core-GT-Logger'
}

{ #category : #initialization }
NonInteractiveTranscriptLoggerStartUp class >> initialize [
	"We register the logger at 91 because the file locator is at 90"
	SessionManager default
		registerSystemClassNamed: self name
		atPriority: 91
]

{ #category : #'system startup' }
NonInteractiveTranscriptLoggerStartUp class >> startUp: isImageStarting [
	isImageStarting
		ifFalse: [ ^ self ].
	
	CommandLineArguments new optionAt: 'beacon-terminal' ifPresent: [ :aValue |
		| theSignals |
		theSignals := ((aValue splitOn: Character space)
			collect: [ :eachPart | eachPart trimBoth ])
			select: [ :eachPart | eachPart isNotEmpty ]
			thenCollect: [ :eachClassName | self environment at: eachClassName asSymbol ].

		theSignals
			ifEmpty: [ NonInteractiveTranscriptLogger start ]
			ifNotEmpty: [ NonInteractiveTranscriptLogger startFor: (AnnouncementSet withAll: theSignals) ] ]
]
