actions
flushLog

	mutex critical:
		[ stream ifNotNil: [ stream flush ] ]