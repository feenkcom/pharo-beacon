private
newLogger
	"Answer a new in-memory logger"
	| root |
	
	self assert: logger isNil.
	root := FileSystem memory root.
	fileReference := root / 'log.log'.
	fallbackReference := root / 'fallback.log'.
	logger := SessionFallbackFileLogger new 
		filename: fileReference;
		fallbackStreamBlock: [ fallbackReference writeStream ].