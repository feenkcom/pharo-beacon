printing
printOneLineContentsOn: stream

	self message ifEmpty:
		[ stream nextPutAll: (self stack first asString 
					copyReplaceAll: String cr 
					with: String cr, 
							String tab, 
							String tab) ]
	ifNotEmpty: [ :message | stream nextPutAll: message ].