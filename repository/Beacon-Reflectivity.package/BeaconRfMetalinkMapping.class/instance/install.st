actions
install
	self astNodes do: [ :anASTNode |
		(anASTNode hasMetalink: self metalink) ifFalse: [
			anASTNode link: self metalink ] ]