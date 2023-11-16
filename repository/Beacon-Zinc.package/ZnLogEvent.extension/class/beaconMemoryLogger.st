*Beacon-Zinc
beaconMemoryLogger
	"Create, start and return a new MemoryLogger using a Beacon
	directly wired to the ZnLogEvents announcer.
	Note that I can be invoked on subclasses."
	
	| beacon memoryLogger |
	beacon := Beacon new. 
	beacon announcer: self announcer.
	memoryLogger := MemoryLogger new.
	memoryLogger name: 'Zinc HTTP'.
	memoryLogger beacon: beacon.
	memoryLogger startFor: self.
	^ memoryLogger