initialization
initialize
	"We register the logger at 91 because the file locator is at 90"
	SessionManager default
		registerSystemClassNamed: self name
		atPriority: 91