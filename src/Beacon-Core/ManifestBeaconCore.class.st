Class {
	#name : #ManifestBeaconCore,
	#superclass : #PackageManifest,
	#category : #'Beacon-Core'
}

{ #category : #accessing }
ManifestBeaconCore class >> mustNotDependOn [
	^ { 
		'Bloc'.
		'Brick'.
	}
]

{ #category : #accessing }
ManifestBeaconCore class >> mustOnlyDependOn [
	^ {'Announcements-Core'.
		'Collections-Sequenceable'.
		'Collections-Strings'.
		'Collections-Unordered'.
		'Kernel'.
		'System-Model'.
		'System-Time'.
		'Transcript-NonInteractive'.
	}
]
