accessing
excludingNormalOperationSignals
	"Answer a set of signals excluding those that are emitted as part of normal operations.
	Excluding those signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ AnnouncementSetWithExclusions new
		add: BeaconSignal;
		addExclusions: (self allSubclasses select: #gtNormalOperationSignal);
		yourself.