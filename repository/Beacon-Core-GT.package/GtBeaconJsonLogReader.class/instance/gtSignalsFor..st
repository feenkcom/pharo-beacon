accessing
gtSignalsFor: aView
	<gtView>

	^ aView forward
		title: 'Signals';
		priority: 10;
		object: [ self memoryLogger ];
		view: #gtRecordingsFor: