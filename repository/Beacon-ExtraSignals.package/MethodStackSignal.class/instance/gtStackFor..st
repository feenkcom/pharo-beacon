as yet unclassified
gtStackFor: aView

	^ aView tree
		title: 'Stack';
		items: [ self stack ];
		priority: 15;
		children: [ :anItem | #() ];
		itemText: [ :anItem | 
			anItem name asRopedText
						append: anItem printString asRopedText ];
		send: [ :anItem | anItem isContext ifTrue: [ anItem ] ifFalse: [ anItem value ] ]