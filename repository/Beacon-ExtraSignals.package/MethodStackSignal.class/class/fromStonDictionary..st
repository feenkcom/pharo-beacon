as yet unclassified
fromStonDictionary: aDictionary
	^ (super fromStonDictionary: aDictionary)
		basicStack: (aDictionary at: #stack);
		yourself