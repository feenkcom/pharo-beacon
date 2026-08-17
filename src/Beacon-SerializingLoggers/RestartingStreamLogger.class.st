"
RestartingStreamLogger extends CustomStreamLogger to be able to automatically open and close the stream with the session.

The default operation is to flush the stream after each message.  This can be turned off.

Public API and Key Messages

- stdout 		Set the stream to stdout
- flush: 		Flag whether to flush the stream after every message

 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
		flush:				<Boolean>		Flag whether to flush the stream after every message
		streamBlock:		<BlockClosure>	Stream creation block


!!!Implementation Points
"
Class {
	#name : #RestartingStreamLogger,
	#superclass : #CustomStreamLogger,
	#instVars : [
		'streamBlock',
		'flush'
	],
	#category : #'Beacon-SerializingLoggers'
}

{ #category : #'instance creation' }
RestartingStreamLogger class >> appendToFile: aFileReference [
	"Create an instance of the receiver on the supplied file"

	instance
		ifNotNil: [ self error: 'RestartingStreamLogger instance already set' ].
	^ self instance appendToFile: aFileReference
]

{ #category : #'class initialization' }
RestartingStreamLogger class >> initialize [
	"Make sure to cleanup on shutdown"
	SessionManager default registerSystemClassNamed: self name
]

{ #category : #'system startup' }
RestartingStreamLogger class >> shutDown [
	"Send close to all our instances.
	Their streams will be reopened on first use later on."
	
	self allInstances do: #close
]

{ #category : #'instance creation' }
RestartingStreamLogger class >> stdout [ 
	"Create an instance of the receiver on stdout"

	instance ifNotNil:
		[ self error: 'RestartingStreamLogger instance already set' ].
	^ self instance stdout
]

{ #category : #'instance creation' }
RestartingStreamLogger >> appendToFile: aFileReference [

	self assert: streamBlock isNil description: 'streamBlock already initialized'.
	self
		streamBlock: [ | fr bstream |
			fr := aFileReference asFileReference.
			bstream := fr binaryWriteStream.
			bstream position: fr size.
			ZnNewLineWriterStream
				on: (ZnCharacterWriteStream on: bstream encoding: 'utf8') ]
]

{ #category : #accessing }
RestartingStreamLogger >> flush [
	^ flush
]

{ #category : #accessing }
RestartingStreamLogger >> flush: anObject [
	flush := anObject
]

{ #category : #initialize }
RestartingStreamLogger >> initialize [ 

	super initialize.
	flush := true.
]

{ #category : #accessing }
RestartingStreamLogger >> nextPutSerialized: anObject [

	mutex critical:
		[ super nextPutSerialized: anObject.
		flush ifTrue: [ self stream flush ] ].
]

{ #category : #'instance creation' }
RestartingStreamLogger >> stdout [ 
	"Initialize the streamBlock to use stdout"

	| theBlock |

	theBlock := [ ZnNewLineWriterStream on: 
			(ZnCharacterWriteStream
					on: Stdio stdout
					encoding: 'utf8') ].
	self
		assert: (streamBlock isNil or: [ streamBlock == theBlock ])
		description: 'streamBlock already initialized'.
	streamBlock := theBlock.
]

{ #category : #accessing }
RestartingStreamLogger >> stream [ 

	^stream ifNil: [ 
		self
			assert: streamBlock isNotNil
			description: 'streamBlock must be initialized'.
		stream := streamBlock value ].
]

{ #category : #accessing }
RestartingStreamLogger >> streamBlock [
	^ streamBlock
]

{ #category : #accessing }
RestartingStreamLogger >> streamBlock: anObject [
	streamBlock := anObject
]
