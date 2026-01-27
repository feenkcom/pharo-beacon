accessing
signals

	^ signals ifNil: [ signals := self load ].