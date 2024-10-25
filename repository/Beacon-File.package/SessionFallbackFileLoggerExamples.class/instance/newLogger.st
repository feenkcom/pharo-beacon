private
newLogger
	"Answer a new in-memory logger"

	self assert: logger isNil.
	fileReference := FileSystem memory root / 'log.log'.
	logger := SessionFallbackFileLogger filename: fileReference.