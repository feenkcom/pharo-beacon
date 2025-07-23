actions
flushLog

	[ super flushLog ]
		on: FileWriteError, PrimitiveFailed
		do: [ :ex |
			usingFallback ifTrue:
				[ ex pass ]
			ifFalse:
				[ | bufferedStream unwritten |
				"Recover the unwritten portion of the current stream, switch to the fallback stream and write the buffer"
				bufferedStream := stream wrappedStream.
				"Copy the unwritten portion of the buffer.
				Ignore the trailing line feed."
				unwritten := bufferedStream buffer copyFrom: 1 to: bufferedStream bufferPosition - 1.
				self useFallbackStream.
				self nextPutSerialized: unwritten utf8Decoded.
				super flushLog. ] ]