*Beacon-Core-GT
fromGtJsonDictionary: aDictionary

	^ (super fromGtJsonDictionary: aDictionary)
		isRetry: (aDictionary at: 'isRetry');
		yourself