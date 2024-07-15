instance creation
emit: anException
	^ self new
		exception: anException;
		emit