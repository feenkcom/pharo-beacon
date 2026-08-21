Class {
	#name : #BaselineOfBeaconCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfBeaconCore
}

{ #category : #baselines }
BaselineOfBeaconCore >> baseline: spec [
	<baseline>

	spec for: #'common' do: [ spec package: #'Beacon-Core' ]
]
