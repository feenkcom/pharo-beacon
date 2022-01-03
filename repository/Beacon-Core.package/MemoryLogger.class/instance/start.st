registering
start

	interestingAnnouncements
		ifNil: [ super start ]
		ifNotNil: [ self startFor: interestingAnnouncements ]