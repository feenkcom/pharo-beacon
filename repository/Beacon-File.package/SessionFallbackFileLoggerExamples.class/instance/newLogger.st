private
newLogger
	"Answer a new in-memory logger"
	| root fallbackWriteStream |

	self assert: logger isNil.
	root := FileSystem memory root.
	fileReference := root / 'log.log'.
	fallbackReference := root / 'fallback.log'.
	fallbackWriteStream := fallbackReference writeStream.
	logger := SessionFallbackFileLogger new 
		filename: fileReference;
		fallbackStreamBlock: [ fallbackWriteStream ].