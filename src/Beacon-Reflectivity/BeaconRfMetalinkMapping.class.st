Class {
	#name : #BeaconRfMetalinkMapping,
	#superclass : #BeaconRfMapping,
	#instVars : [
		'metalink',
		'astNodes'
	],
	#category : #'Beacon-Reflectivity'
}

{ #category : #accessing }
BeaconRfMetalinkMapping >> addAstNode: anAstNode [
	self astNodes add: anAstNode
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> addAstNodes: anAstNode [
	self astNodes add: anAstNode
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> addMethod: aCompiledMethod [
	self addAstNode: aCompiledMethod ast
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> addMethods: compiledMethods [
	compiledMethods do: [ :each | self addMethod: each ]
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> astNodes [
	^ astNodes ifNil: [ astNodes := OrderedCollection new ]
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> astNodes: anASTsCollection [
	astNodes := anASTsCollection
]

{ #category : #actions }
BeaconRfMetalinkMapping >> install [
	self astNodes do: [ :anASTNode |
		(anASTNode hasMetalink: self metalink) ifFalse: [
			anASTNode link: self metalink ] ]
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> metalink [
	^ metalink
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> metalink: aMetalink [
	metalink := aMetalink
]

{ #category : #metalinks }
BeaconRfMetalinkMapping >> metalinkWith: aBlock [
	self metalink: (MetaLink new
		metaObject: aBlock;
		selector: #value)
]

{ #category : #accessing }
BeaconRfMetalinkMapping >> metalinks [
	^ { self metalink }
]
