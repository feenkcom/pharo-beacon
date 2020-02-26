instance creation
stdout 
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