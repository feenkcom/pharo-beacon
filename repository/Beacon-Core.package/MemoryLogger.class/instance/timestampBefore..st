enumerating
timestampBefore: aDateAndTime

	^ (self select: [ :each |
		each timestamp < aDateAndTime asDateAndTime ])
			name: 'Records prior to: ', aDateAndTime asString.