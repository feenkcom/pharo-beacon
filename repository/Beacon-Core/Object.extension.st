Extension { #name : #Object }

{ #category : #'*Beacon-Core' }
Object >> asBeaconSignal [
	<gtPharoPatch: #Pharo>
	^ WrapperSignal on: self
]
