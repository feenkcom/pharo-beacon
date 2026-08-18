Class {
	#name : #BaselineOfBeaconForGlamorousToolkit,
	#superclass : #BaselineOf,
	#category : #BaselineOfBeaconForGlamorousToolkit
}

{ #category : #baselines }
BaselineOfBeaconForGlamorousToolkit >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec baseline: 'BeaconCore' with: [
				spec repository: 'github://feenkcom/pharo-beacon/src' ].
		spec 
			package: #'Beacon-Core-GT' with: [
				spec requires: #('BeaconCore' #'Beacon-ExtraSignals'). ];
			package: #'Beacon-Core-Tests' with: [
				spec requires: #('BeaconCore' ). ];
			package: #'Beacon-SerializingLoggers' with: [ spec requires: #('BeaconCore') ];
			package: #'Beacon-ExtraSignals' with: [ spec requires: #('BeaconCore') ];
			package: #'Beacon-Extra-Tests' with: [ spec requires: #('Beacon-SerializingLoggers' 'Beacon-ExtraSignals') ];
			package: #'Beacon-Syslog' with: [ spec requires: #('Beacon-SerializingLoggers') ];
			package: #'Beacon-File' with: [ spec requires: #('Beacon-SerializingLoggers') ];
			package: #'Beacon-Zinc' with: [ spec requires: #(#'BeaconCore') ] ].
]
