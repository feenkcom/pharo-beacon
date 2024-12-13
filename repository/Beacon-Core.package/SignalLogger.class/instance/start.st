registering
start
	"by default we eliminate the normal operation signals because 
	it is both noisy and can lead to an infinite loop when inspecting a logger visually
	(because the viewing emits new signals).
	If you need to see those as well, use startFor: BeaconSignal"
	self startFor: BeaconSignal excludingNormalOperationSignals