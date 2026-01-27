gt - extensions
gtPropertiesFor: aView
	<gtView>
	
	^ aView forward
		title: 'Properties';
		priority: 30;
		object: [ properties ];
		view: #gtLiveFor: