instance creation
appendToFile: aFileReference

	self assert: streamBlock isNil description: 'streamBlock already initialized'.
	self
		streamBlock: [ | fr bstream |
			fr := aFileReference asFileReference.
			bstream := fr binaryWriteStream.
			bstream position: fr size.
			ZnNewLineWriterStream
				on: (ZnCharacterWriteStream on: bstream encoding: 'utf8') ]