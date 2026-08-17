Class {
	#name : #BeaconRfMapping,
	#superclass : #Object,
	#category : #'Beacon-Reflectivity'
}

{ #category : #actions }
BeaconRfMapping >> install [
	self subclassResponsibility
]

{ #category : #accessing }
BeaconRfMapping >> metalinks [
	self subclassResponsibility
]

{ #category : #actions }
BeaconRfMapping >> uninstall [
	self metalinks do: #uninstall
]
