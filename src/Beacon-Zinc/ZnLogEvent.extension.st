Extension { #name : #ZnLogEvent }

{ #category : #'*Beacon-Zinc' }
ZnLogEvent class >> beaconMemoryLogger [
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
]

{ #category : #'*Beacon-Zinc' }
ZnLogEvent class >> logToBeacon [
	self stopLoggingToBeacon.
	^ self announcer 
		when: ZnLogEvent 
		do: [ :event | (ZnLogEventSignal on: event) emit ]
		for: self
]

{ #category : #'*Beacon-Zinc' }
ZnLogEvent >> name [
	^ self class name
]

{ #category : #'*Beacon-Zinc' }
ZnLogEvent >> printOneLineContentsOn: stream [
	self printContentsOn: stream 
]

{ #category : #'*Beacon-Zinc' }
ZnLogEvent class >> stopLoggingToBeacon [.
	self announcer unsubscribe: self
]
