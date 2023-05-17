accessing
gtViewTopVariablesFor: aView
	<gtView>
	^ self stack 
		ifEmpty: [ aView empty  ]
		ifNotEmpty: [ :aStack |
			(aStack first gtVariablesFor: aView)
				title: 'Top variables' ]