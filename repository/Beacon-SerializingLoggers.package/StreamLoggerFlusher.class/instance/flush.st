private
flush

	[ logger flushLog ] 
		forkAt: Processor userBackgroundPriority 
		named: 'StreamLogger flush'.