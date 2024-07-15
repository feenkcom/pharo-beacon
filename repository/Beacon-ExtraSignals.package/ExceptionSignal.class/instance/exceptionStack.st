accessing
exceptionStack
	^ exceptionStack ifNil: [ exceptionStack := self currentExceptionStack ]