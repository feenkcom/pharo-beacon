initialize
prepareForDelivery
	"I only store the stack when a concrete logger is interested in me"

	super prepareForDelivery.
	self exceptionStack.