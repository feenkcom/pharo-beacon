Class {
	#name : #ManifestBeaconCore,
	#superclass : #PackageManifest,
	#category : #'Beacon-Core'
}

{ #category : #'as yet unclassified' }
ManifestBeaconCore class >> mustNotDependOn [
	^ { 
		'Bloc'.
		'Brick'.
	}
]

{ #category : #'as yet unclassified' }
ManifestBeaconCore class >> mustOnlyDependOn [
	^ {'Announcements-Core'.
		'Collections-Sequenceable'.
		'Collections-Strings'.
		'Collections-Unordered'.
		'Kernel'.
		'System-Model'.
		'System-Time'.
		'Transcript-NonInteractive'.
		'UnifiedFFI'.
	}
]
