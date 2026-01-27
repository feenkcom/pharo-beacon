as yet unclassified
checkReadError: anException in: aStream
	"If the stream is large enough and near the end, assume that it is still open and being written to, in which case we can just use the records already read."

	(aStream size > 4096 and: [ (aStream position / aStream size) > 0.95 ]) ifTrue: [ ^ self ].
	self error: 'Unexpected error while reading log'.