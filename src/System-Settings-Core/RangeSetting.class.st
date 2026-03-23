"
I represent a setting for which the domain value is an interval.
"
Class {
	#name : 'RangeSetting',
	#superclass : 'Setting',
	#instVars : [
		'range'
	],
	#category : 'System-Settings-Core-Base-New',
	#package : 'System-Settings-Core',
	#tag : 'Base-New'
}

{ #category : 'accessing' }
RangeSetting >> range [
	^ range
]

{ #category : 'accessing' }
RangeSetting >> range: anInterval [ 
	range := anInterval
]
