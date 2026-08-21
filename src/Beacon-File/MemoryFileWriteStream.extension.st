Extension { #name : #MemoryFileWriteStream }

{ #category : #'*Beacon-File' }
MemoryFileWriteStream >> name [

	^ 'memory'
]

{ #category : #'*Beacon-File' }
MemoryFileWriteStream >> wrappedStream [

	^ nil
]
