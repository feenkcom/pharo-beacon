printing
stonOn: stonWriter
	stonWriter
		writeObject: self
		streamShortList: [ :array | array add: self asDictionary ]