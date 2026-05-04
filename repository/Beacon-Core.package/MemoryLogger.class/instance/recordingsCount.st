accessing
recordingsCount
	^ recordings ifNil: [0] ifNotNil: [ :aCollection | aCollection size ]