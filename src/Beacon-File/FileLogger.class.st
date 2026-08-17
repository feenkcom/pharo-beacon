"
An implementation of a simple file logger using filename and encoding as parameter. 

It can be used like

FileLogger new
	filename: '/tmp/test.log';
	runFor: StringSignal during: [ 
		StringSignal emit: 'test message'
		]



 



"
Class {
	#name : #FileLogger,
	#superclass : #StreamLogger,
	#instVars : [
		'fileReference',
		'encoding',
		'binary',
		'stream',
		'lineSeparator'
	],
	#category : #'Beacon-File-Loggers'
}

{ #category : #defaults }
FileLogger class >> defaultEncoding [
	^ 'utf-8'
]

{ #category : #'instance creation' }
FileLogger class >> filename: aString [
	^ self filename: aString append: true
]

{ #category : #'instance creation' }
FileLogger class >> filename: aStringOrFileReference append: appending [
	^ self instance
		filename: aStringOrFileReference;
		append: appending
]

{ #category : #'instance creation' }
FileLogger class >> stdout [
	^ self new
		stream: Stdio stdout	
]

{ #category : #accessing }
FileLogger >> append [
	self append: true
]

{ #category : #accessing }
FileLogger >> append: aBoolean [
	aBoolean ifTrue: [
		mutex critical:
			[ self stream setToEnd ] ]
]

{ #category : #accessing }
FileLogger >> binary [
	^ binary
]

{ #category : #accessing }
FileLogger >> binary: anObject [
	binary := anObject
]

{ #category : #initialization }
FileLogger >> close [
	"Close the receivers stream if it is open"

	mutex critical: [ self stream ifNotNil: [ :theStream | 
		(self isStdioStream: theStream) ifFalse:
			[ theStream closed ifFalse: 
				[ theStream close ].
				stream := nil ] ] ]
]

{ #category : #defaults }
FileLogger >> defaultEncoding [
	^ self class defaultEncoding
]

{ #category : #defaults }
FileLogger >> defaultLineSeparator [
	^ Character lf
]

{ #category : #accessing }
FileLogger >> encoder [
	^ ZnCharacterEncoder newForEncoding: self encoding
]

{ #category : #accessing }
FileLogger >> encoding [
	^ encoding ifNil: [ 
		encoding := self defaultEncoding ] 
]

{ #category : #accessing }
FileLogger >> encoding: anObject [
	^ encoding := anObject
]

{ #category : #'as yet unclassified' }
FileLogger >> fileReference [

	^ fileReference
]

{ #category : #accessing }
FileLogger >> filename: aStringOrFileReference [
	fileReference := aStringOrFileReference asFileReference 
	
]

{ #category : #actions }
FileLogger >> flushLog [

	mutex critical:
		[ self stream ifNotNil: [ :theStream | theStream flush ] ]
]

{ #category : #initialization }
FileLogger >> initialize [
	super initialize.
	binary := false
]

{ #category : #testing }
FileLogger >> isStdioStream: theStream [
	| innerStream |

	innerStream := theStream.
	[ innerStream wrappedStream isNil ] whileFalse:
		[ innerStream := innerStream wrappedStream ].
	^ #('stdout' 'stderr') includes: innerStream name
]

{ #category : #accessing }
FileLogger >> lineSeparator [
	^ lineSeparator ifNil: [
		lineSeparator := self defaultLineSeparator ]
]

{ #category : #accessing }
FileLogger >> newStream [
	| newStream |
	newStream := fileReference writeStream.
	binary ifFalse: [ 
		newStream encoder: self encoder ].
	^ newStream 
]

{ #category : #accessing }
FileLogger >> nextPutSerialized: aString [

	mutex critical:
		[ super nextPutSerialized: aString.
		self stream nextPut: self lineSeparator. ].
]

{ #category : #accessing }
FileLogger >> stream [
	^ stream ifNil: [ 
		stream := self newStream ] 
]

{ #category : #accessing }
FileLogger >> stream: aStream [
	stream := aStream
]
