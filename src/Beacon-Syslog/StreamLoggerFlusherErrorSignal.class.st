"
StreamLoggerFlusherErrorSignal is emitted when an exception occurs while attempting to flush a logger.
"
Class {
	#name : #StreamLoggerFlusherErrorSignal,
	#superclass : #BeaconLoggerSignal,
	#instVars : [
		'flusher'
	],
	#category : #'Beacon-Syslog-Extensions'
}

{ #category : #'instance creation' }
StreamLoggerFlusherErrorSignal class >> signal: aFlusher [

	self new
		flusher: aFlusher;
		emit
]

{ #category : #accessing }
StreamLoggerFlusherErrorSignal >> flusher [
	^ flusher
]

{ #category : #accessing }
StreamLoggerFlusherErrorSignal >> flusher: anObject [
	flusher := anObject
]
