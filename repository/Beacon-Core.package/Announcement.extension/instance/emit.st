*Beacon-Core-Core
emit
	<gtPharoPatch: #Pharo>
	"Convert the receiver as a beacon signal to the main signal dispatcher so that registered loggers get a chance to act on signal reception."
	
	Beacon announce: self asBeaconSignal