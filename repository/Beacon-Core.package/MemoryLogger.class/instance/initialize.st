initialize
initialize
	super initialize.
	mutex := Mutex new.
	announcer := Announcer new.
	self reset.
