"
This signal logger simply records the signals that it receives.

##Example1: Instance usage
```
(MemoryLogger new 
		runDuring: [ 
			StringSignal emit: 'This is a message' ]	)
				inspect.
```

##Example 2: Global usage

```
	MemoryLogger reset.
	MemoryLogger start.
	StringSignal emit: 'This is a message' .
	MemoryLogger instance recordings inspect.
	MemoryLogger stop.
```
"
Class {
	#name : #MemoryLogger,
	#superclass : #SignalLogger,
	#instVars : [
		'recordings',
		'announcer',
		'mutex',
		'interestingAnnouncements'
	],
	#classVars : [
		'WriteFilename',
		'WritePeriod',
		'WriteProcess'
	],
	#category : #'Beacon-Core-Loggers'
}

{ #category : #registering }
MemoryLogger class >> reset [
	self instance reset
]

{ #category : #'instance creation' }
MemoryLogger class >> withRecordings: aCollection [

	^self new initializeWithRecordings: aCollection
]

{ #category : #accessing }
MemoryLogger >> announcer [ 
	"The announcer announces to potential watchers (typically viewers)
	that a new signal was recorded"
	^ announcer
]

{ #category : #accessing }
MemoryLogger >> asDictionary [
	^ Dictionary new
		at: #name put: name;
		at: #recordings put: recordings;
		yourself
]

{ #category : #initialization }
MemoryLogger >> basicRecordings: aCollection [
	"Set the receiver's recordings.
	This is normally only used when loading saved instances from file"

	recordings := aCollection
]

{ #category : #accessing }
MemoryLogger >> entries [
	"Pharo compatibility"
	^ self recordings
]

{ #category : #accessing }
MemoryLogger >> entryCount [
	^ self recordingsCount
]

{ #category : #enumerating }
MemoryLogger >> first: anInteger [
	"Answer a new instance of the receiver with only the requested signals"

	^(self class withRecordings: (self recordings first: anInteger))
		name: 'First: ', anInteger asString.
]

{ #category : #testing }
MemoryLogger >> hasEntries [

	^ self hasRecordings
]

{ #category : #testing }
MemoryLogger >> hasRecordings [

	^ recordings isNotEmpty 
]

{ #category : #initialize }
MemoryLogger >> initialize [
	super initialize.
	mutex := Mutex new.
	announcer := Announcer new.
	self reset
]

{ #category : #initialization }
MemoryLogger >> initializeAnnouncer [
	announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
MemoryLogger >> initializeInterestingSubscriptionsWith: anAnnouncementOrASetOfAnnouncements [ 
	interestingAnnouncements := anAnnouncementOrASetOfAnnouncements.
]

{ #category : #initialization }
MemoryLogger >> initializeWithRecordings: aCollection [
	"Set the receiver's recordings.
	This is normally only used when loading saved instances from file"
	recordings := aCollection
]

{ #category : #accessing }
MemoryLogger >> interestingSubscriptions [
	^ interestingAnnouncements
]

{ #category : #accessing }
MemoryLogger >> nextPut: aSignal [
	mutex critical: [
		recordings add: aSignal ].
	"the announcement is passed forward so that potential viewers
	can refresh when something changes. we do not create another announcement
	because it is not needed given that the only thing that can happen is
	for a new announcement to be recorded"
	self announcer announce: aSignal
]

{ #category : #accessing }
MemoryLogger >> recordings [
	"It answers a copy of the recorded collection to not grant
	access to the users to a shared resource that should only be 
	modified via the mutex"
	^ recordings copy
]

{ #category : #accessing }
MemoryLogger >> recordingsCount [
	^ recordings ifNil: [0] ifNotNil: [ :aCollection | aCollection size ]
]

{ #category : #enumerating }
MemoryLogger >> reject: aBlock [
	"Answer a new instance of the receiver with only the selected signals"

	^(self class withRecordings: (self recordings reject: aBlock))
		name: aBlock printString.
]

{ #category : #initialize }
MemoryLogger >> reset [
	"it simply removes all recordings without
	affecting the running status of the logger"
	mutex critical: [
		recordings := OrderedCollection new ].
	self announcer announce: (ValueChanged newValue: recordings).
]

{ #category : #enumerating }
MemoryLogger >> select: aBlock [
	"Answer a new instance of the receiver with only the selected signals"

	^(self class withRecordings: (self recordings select: aBlock))
		name: aBlock printString.
]

{ #category : #registering }
MemoryLogger >> start [

	interestingAnnouncements
		ifNil: [ super start ]
		ifNotNil: [ self startFor: interestingAnnouncements ]
]

{ #category : #running }
MemoryLogger >> startFor: anAnnouncementOrASetOfAnnouncements [

	self initializeInterestingSubscriptionsWith:  anAnnouncementOrASetOfAnnouncements.
	^ super startFor: anAnnouncementOrASetOfAnnouncements
]

{ #category : #printing }
MemoryLogger >> stonOn: stonWriter [
	stonWriter
		writeObject: self
		streamShortList: [ :array | array add: self asDictionary ]
]

{ #category : #enumerating }
MemoryLogger >> timestampBefore: aDateAndTime [
	^ (self select: [ :each |
		each timestamp < aDateAndTime asDateAndTime ])
			name: 'Records prior to: ', aDateAndTime asString.
]

{ #category : #enumerating }
MemoryLogger >> timestampBetween: startDateAndTime and: endDateAndTime [
	| start end |

	start := startDateAndTime asDateAndTime.
	end := endDateAndTime asDateAndTime.
	^ (self select: [ :each | each timestamp between: start and: end ])
			name: 'Records between: ', startDateAndTime asString,
				' and: ', endDateAndTime asString.
]
