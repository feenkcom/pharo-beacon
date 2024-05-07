initialize
relevantStackWithoutSelf
	| s |
	s := thisContext stack collect: #copy.
	^ s allButFirst: (s findLast: [ :each | each receiver == self or: [ each receiver == self class ] ])