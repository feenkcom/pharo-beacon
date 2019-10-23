accessing
stream 

	^stream ifNil: [ 
		self
			assert: streamBlock isNotNil
			description: 'streamBlock must be initialized'.
		stream := streamBlock value ].