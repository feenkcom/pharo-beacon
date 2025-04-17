printing
printOneLineContentsOn: stream
	"hook to be overriden by subclasses"

	self message ifNotEmpty: [ :message |
		stream << message ].