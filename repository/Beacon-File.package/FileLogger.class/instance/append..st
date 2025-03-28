accessing
append: aBoolean
	aBoolean ifTrue: [
		mutex critical:
			[ self stream setToEnd ] ]