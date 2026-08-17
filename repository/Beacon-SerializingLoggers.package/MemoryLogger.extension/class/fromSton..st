*Beacon-SerializingLoggers
fromSton: stonReader
	| logger |

	logger := self basicNew.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		logger
			name: (each at: #name);
			initializeWithRecordings: (each at: #recordings) ].
	logger initializeAnnouncer.
	^ logger