I use ${class:NonInteractiveTranscript}$ to log activities.
In particular I use ${method:NonInteractiveTranscript class>>#stdout}$ standard output.

Example:

[[[  
NonInteractiveTranscriptLogger runDuring: [ 
	StringSignal emit: 'This is a message'.
	StringSignal emit: 'The red fox jumps over the lazy dog'. ]			
]]]

