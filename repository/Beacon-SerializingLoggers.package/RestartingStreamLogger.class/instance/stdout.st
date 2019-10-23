instance creation
stdout 
	"Initialize the streamBlock to use stdout"

	| theBlock |

	theBlock := [ ZnNewLineWriterStream on: Stdio stdout ].
	self
		assert: (streamBlock isNil or: [ streamBlock == theBlock ])
		description: 'streamBlock already initialized'.
	streamBlock := theBlock.