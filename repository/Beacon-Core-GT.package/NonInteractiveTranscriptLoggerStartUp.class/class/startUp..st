system startup
startUp: isImageStarting
	isImageStarting
		ifFalse: [ ^ self ].
	
	(CommandLineArguments new hasOption: 'beacon-terminal')
		ifTrue: [ NonInteractiveTranscriptLogger start ]