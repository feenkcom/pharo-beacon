actions
flushLog

	mutex critical:
		[ self stream ifNotNil: [ :theStream | theStream flush ] ]