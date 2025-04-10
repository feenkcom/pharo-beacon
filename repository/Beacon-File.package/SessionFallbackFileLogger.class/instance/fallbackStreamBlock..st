accessing
fallbackStreamBlock: aBlockClosure
	"Set the block that will create the fallback stream.
	The block is responsible for setting the encoding on the stream (typically UTF-8)."

	fallbackStreamBlock := aBlockClosure