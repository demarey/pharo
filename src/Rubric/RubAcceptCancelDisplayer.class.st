Class {
	#name : #RubAcceptCancelDisplayer,
	#superclass : #RubScrolledTextExtraSurface,
	#instVars : [
		'acceptButton',
		'cancelButton'
	],
	#category : #'Rubric-Editing-Widgets'
}

{ #category : #accessing }
RubAcceptCancelDisplayer class >> key [
	^ #acceptcancel
]

{ #category : #action }
RubAcceptCancelDisplayer >> accept [

	self owner accept
]

{ #category : #accessing }
RubAcceptCancelDisplayer >> acceptButton [

	^ acceptButton ifNil: [ acceptButton := self newButtonWithIcon: #acceptIcon action: #accept ]
]

{ #category : #accessing }
RubAcceptCancelDisplayer >> acceptIcon [

	^ self iconNamed: #glamorousAccept
]

{ #category : #action }
RubAcceptCancelDisplayer >> cancel [

	self owner cancel.
	self updateVisibility.
]

{ #category : #accessing }
RubAcceptCancelDisplayer >> cancelButton [

	^ cancelButton ifNil: [ cancelButton := self newButtonWithIcon: #cancelIcon action: #cancel ]
]

{ #category : #accessing }
RubAcceptCancelDisplayer >> cancelIcon [
	
	"Cancel icon is 16x16 whereas Accept icons is 14x14."
	^ (self iconNamed: #glamorousCancel) scaledToSize: 14@14
]

{ #category : #'instance creation' }
RubAcceptCancelDisplayer >> initialize [ 

	super initialize.
	self visible: false.
	self addMorph: self acceptButton.
	self addMorph: self cancelButton.
]

{ #category : #events }
RubAcceptCancelDisplayer >> layoutChanged [ 

	super layoutChanged.
	self acceptButton position: (self bounds bottomRight - self margin) - self acceptButton extent.
	self cancelButton position: self acceptButton position - (self margin @ 0) - (self acceptButton extent x @ 0).
]

{ #category : #accessing }
RubAcceptCancelDisplayer >> level [
	^ -2
]

{ #category : #accessing }
RubAcceptCancelDisplayer >> margin [

	^ 5
]

{ #category : #'instance creation' }
RubAcceptCancelDisplayer >> newButtonWithIcon: iconSelectorName action: selectorName [

	| button |
	button := PluggableButtonMorph
		on: self
		getState: nil
		action: selectorName
		label: nil 
		icon: iconSelectorName
		menu: nil. 	
	button cornerStyle: #rounded.
	^ button
]

{ #category : #private }
RubAcceptCancelDisplayer >> privateOwner: aMorph [

	super privateOwner: aMorph.
	self subscribeOnTextChanges.
]

{ #category : #events }
RubAcceptCancelDisplayer >> subscribeOnTextChanges [

	self owner announcer 		
		when: RubTextAccepted send: #textChanged: to: self;
		when: RubTextChanged send: #textChanged: to: self;
		when: RubCancelEditRequested send: #textChanged: to: self
]

{ #category : #events }
RubAcceptCancelDisplayer >> textChanged [

	self paragraphProvider isReadOnly ifTrue: [ ^ self ].
	self updateVisibility.

]

{ #category : #events }
RubAcceptCancelDisplayer >> textChanged: aTextChanged [

	self textChanged.
]

{ #category : #updating }
RubAcceptCancelDisplayer >> updateVisibility [	
	
	self visible: self paragraphProvider hasUnacceptedEdits.

]
