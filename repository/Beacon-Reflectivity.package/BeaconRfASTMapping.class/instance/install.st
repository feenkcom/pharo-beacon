actions
install
	self metalinks do: [ :aMetalink |
		(self astNode hasMetalink: aMetalink) ifFalse: [
			self astNode  link: aMetalink ] ]