enumerating
timestampBetween: startDateAndTime and: endDateAndTime
	| start end |

	start := startDateAndTime asDateAndTime.
	end := endDateAndTime asDateAndTime.
	^ (self select: [ :each | each timestamp between: start and: end ])
			name: 'Records between: ', startDateAndTime asString,
				' and: ', endDateAndTime asString.