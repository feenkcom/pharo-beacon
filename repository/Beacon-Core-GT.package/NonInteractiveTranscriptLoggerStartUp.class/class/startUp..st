system startup
startUp: isImageStarting
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