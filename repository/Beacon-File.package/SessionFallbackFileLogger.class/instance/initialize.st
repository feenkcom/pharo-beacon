initialization
initialize

	super initialize.
	usingFallback := false.
	fallbackStreamBlock := [ Stdio stdout ].