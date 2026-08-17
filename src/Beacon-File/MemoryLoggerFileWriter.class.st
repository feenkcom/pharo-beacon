Class {
	#name : #MemoryLoggerFileWriter,
	#superclass : #Object,
	#classVars : [
		'WriteFilename',
		'WritePeriod',
		'WriteProcess'
	],
	#category : #'Beacon-File-Loggers'
}

{ #category : #accessing }
MemoryLoggerFileWriter class >> save: aLogger stonFile: aFileReference [
	"Save the receiver to the supplied file name"
	| stream |

	stream := (ZnCharacterWriteStream 
		on: (GZipWriteStream on: aFileReference asFileReference nextVersion binaryWriteStream)
		encoding: 'utf8').
	[ STON put: aLogger onStreamPretty: stream ]
		ensure: [ stream close ].
]

{ #category : #saving }
MemoryLoggerFileWriter class >> startAutoSaving: aLogger [
	"Write the default instance to a file every WritePeriod"

	WriteProcess ifNotNil: [ self error: 'Write process already running' ].

	WriteProcess := [ self writeLoop: aLogger ]
		forkAt: Processor userInterruptPriority
		named: aLogger class name, ' auto-save'.
]

{ #category : #saving }
MemoryLoggerFileWriter class >> stopAutoSaving [
	"Terminate writing the default instance to a file every WritePeriod"

	WriteProcess ifNil: [ ^self ].
	WriteProcess terminate.
	100 milliSeconds wait.
	WriteProcess isTerminated ifFalse: [ self error: 'Unable to terminate auto-save process' ].
	WriteProcess := nil.
]

{ #category : #accessing }
MemoryLoggerFileWriter class >> writeFilename [

	^WriteFilename ifNil: [ WriteFilename := String streamContents: [ :stream |
			stream 
				<< self name;
				<< '-';
				print: LibC uniqueInstance currentProcessId;
				<< '.stgz' ] ].
]

{ #category : #accessing }
MemoryLoggerFileWriter class >> writeFilename: aFilename [

	WriteFilename := aFilename 
]

{ #category : #private }
MemoryLoggerFileWriter class >> writeLoop: aLogger [
	"Write the default instance out to a file every WritePeriod"

	[
		self save: aLogger stonFile: self writeFilename value.
		self writePeriod wait ] repeat.
]

{ #category : #accessing }
MemoryLoggerFileWriter class >> writePeriod [

	^WritePeriod ifNil: [ WritePeriod := 60 seconds ]
]

{ #category : #accessing }
MemoryLoggerFileWriter class >> writePeriod: aDuration [

	WritePeriod := aDuration
]
