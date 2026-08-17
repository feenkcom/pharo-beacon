Class {
	#name : #BeaconRfASTMapping,
	#superclass : #BeaconRfMapping,
	#instVars : [
		'astNode',
		'metalinks'
	],
	#category : #'Beacon-Reflectivity'
}

{ #category : #accessing }
BeaconRfASTMapping >> astNode [
	^ astNode
]

{ #category : #accessing }
BeaconRfASTMapping >> astNode: anAstNode [
	astNode := anAstNode
]

{ #category : #actions }
BeaconRfASTMapping >> install [
	self metalinks do: [ :aMetalink |
		(self astNode hasMetalink: aMetalink) ifFalse: [
			self astNode  link: aMetalink ] ]
]

{ #category : #accessing }
BeaconRfASTMapping >> metalinks [
	^ metalinks
]

{ #category : #accessing }
BeaconRfASTMapping >> metalinks: aCollectionOfMetalinks [
	metalinks := aCollectionOfMetalinks
]
