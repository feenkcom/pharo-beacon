Class {
	#name : #BaselineOfBeacon,
	#superclass : #BaselineOf,
	#category : #BaselineOfBeacon
}

{ #category : #baseline }
BaselineOfBeacon >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'BeaconCore' with: [
				spec repository: 'github://feenkcom/pharo-beacon:v0.5.125/src' ].

		spec package: 'Beacon-Core-Tests' with: [
			spec requires: #(#BeaconCore) ].
		spec package: 'Beacon-SerializingLoggers' with: [
			spec requires: #(#BeaconCore) ].
		spec package: 'Beacon-ExtraSignals' with: [
			spec requires: #(#BeaconCore) ].
		spec package: 'Beacon-Core-GT' with: [
			spec requires: #(#BeaconCore #'Beacon-ExtraSignals') ].
		spec package: 'Beacon-Extra-Tests' with: [
			spec requires: #(#'Beacon-SerializingLoggers' #'Beacon-ExtraSignals') ].
		spec package: 'Beacon-Syslog' with: [
			spec requires: #(#'Beacon-SerializingLoggers') ].
		spec package: 'Beacon-File' with: [
			spec requires: #(#'Beacon-SerializingLoggers') ].
		spec package: 'Beacon-Zinc' with: [
			spec requires: #(#BeaconCore) ].
	]
]
