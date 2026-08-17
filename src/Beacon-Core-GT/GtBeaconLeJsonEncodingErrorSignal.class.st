Class {
	#name : #GtBeaconLeJsonEncodingErrorSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'encodingError'
	],
	#category : #'Beacon-Core-GT-Extensions'
}

{ #category : #accessing }
GtBeaconLeJsonEncodingErrorSignal >> encodingError [
	^ encodingError
]

{ #category : #accessing }
GtBeaconLeJsonEncodingErrorSignal >> encodingError: anObject [
	encodingError := anObject
]

{ #category : #printing }
GtBeaconLeJsonEncodingErrorSignal >> printOneLineContentsOn: stream [

	stream
		print: encodingError
]
