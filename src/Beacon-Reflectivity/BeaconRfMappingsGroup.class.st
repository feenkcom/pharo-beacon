Class {
	#name : #BeaconRfMappingsGroup,
	#superclass : #Object,
	#instVars : [
		'mappings'
	],
	#category : #'Beacon-Reflectivity'
}

{ #category : #adding }
BeaconRfMappingsGroup >> addMapping: aMapping [
	self mappings add: aMapping
]

{ #category : #adding }
BeaconRfMappingsGroup >> addMappings: aMappingCollection [
	self mappings addAll: aMappingCollection
]

{ #category : #actions }
BeaconRfMappingsGroup >> install [
	self mappings do: #install
]

{ #category : #accessing }
BeaconRfMappingsGroup >> mappings [
	^ mappings ifNil: [ mappings := OrderedCollection new ]
]

{ #category : #actions }
BeaconRfMappingsGroup >> uninstall [
	self mappings do: #uninstall
]
