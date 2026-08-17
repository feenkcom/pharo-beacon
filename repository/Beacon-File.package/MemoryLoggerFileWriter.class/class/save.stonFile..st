accessing
save: aLogger stonFile: aFileReference
	"Save the receiver to the supplied file name"
	| stream |

	stream := (ZnCharacterWriteStream 
		on: (GZipWriteStream on: aFileReference asFileReference nextVersion binaryWriteStream)
		encoding: 'utf8').
	[ STON put: aLogger onStreamPretty: stream ]
		ensure: [ stream close ].