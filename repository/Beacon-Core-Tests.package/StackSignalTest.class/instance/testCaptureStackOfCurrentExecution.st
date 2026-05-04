tests
testCaptureStackOfCurrentExecution
	<gtPharoPatch: #Patch>
	"Disable this test as StackSignal is not in GT"
	
"	| m |
	m := MemoryLogger new.
	m	runDuring: [ 
			ContextStackSignal emit ].
	
	self assert: m entries first stack selector equals: thisContext selector"
