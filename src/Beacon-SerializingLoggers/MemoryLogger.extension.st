Extension { #name : #MemoryLogger }

{ #category : #'*Beacon-SerializingLoggers' }
MemoryLogger class >> fromSton: stonReader [
	| logger |

	logger := self basicNew.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		logger
			name: (each at: #name);
			initializeWithRecordings: (each at: #recordings) ].
	logger initializeAnnouncer.
	^ logger
]

{ #category : #'*Beacon-SerializingLoggers' }
MemoryLogger class >> fromStonFile: aFileReference [
	| logger |

	logger := aFileReference asFileReference binaryReadStreamDo: [ :bstream |
		STON fromStream: (ZnCharacterReadStream 
			on: (GZipReadStream on: bstream)
			encoding: 'utf8') ].
	logger initializeAnnouncer.
	^ logger
]
