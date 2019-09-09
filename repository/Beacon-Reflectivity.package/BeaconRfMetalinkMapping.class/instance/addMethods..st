accessing
addMethods: compiledMethods
	compiledMethods do: [ :each | self addMethod: each ]