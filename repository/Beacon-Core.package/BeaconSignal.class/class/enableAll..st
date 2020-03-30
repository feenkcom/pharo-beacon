accessing
enableAll: aBoolean
	"Enable/disable the receiver and all subclasses"

	self withAllSubclassesDo: [ :each | each enabled: aBoolean ]