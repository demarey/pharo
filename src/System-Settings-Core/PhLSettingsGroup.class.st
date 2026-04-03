"
I represent a Setting Category. I hold some data on the category.
I'm identified by my name. Settinng refer to me by this name.
"
Class {
	#name : 'PhLSettingsGroup',
	#superclass : 'AbstractSetting',
	#instVars : [
		'isActive',
		'isActivable'
	],
	#category : 'System-Settings-Core-Base-New',
	#package : 'System-Settings-Core',
	#tag : 'Base-New'
}

{ #category : 'private - building' }
PhLSettingsGroup >> asParentWhile: aBlock [

	self builder parent: self while: aBlock
]

{ #category : 'testing' }
PhLSettingsGroup >> hasDefaultValue [

	"Group should manage its visibily. When done, this methods should check the value of the visibility against the default value"
	^ true
]

{ #category : 'initialization' }
PhLSettingsGroup >> initialize [ 

	super initialize.
	isActivable := false.
]

{ #category : 'initialization' }
PhLSettingsGroup >> initializeBlocks [

	readBlock := [ self settingReceiver perform: self name ].
	writeBlock := [ :value | self settingReceiver perform: self name , ':' withArguments: { value } ]
]

{ #category : 'accessing' }
PhLSettingsGroup >> isActivable [

	^ isActivable
]

{ #category : 'accessing' }
PhLSettingsGroup >> isActivable: aBoolean [

	isActivable := aBoolean.
	isActivable ifTrue: [ self initializeBlocks ]
]

{ #category : 'accessing' }
PhLSettingsGroup >> isActive [

	^ isActive
]

{ #category : 'accessing' }
PhLSettingsGroup >> isActive: aBoolean [

	isActive := aBoolean.
	self isActivable: true
]

{ #category : 'testing' }
PhLSettingsGroup >> isGroup [
	
	^ true
]

{ #category : 'accessing' }
PhLSettingsGroup >> realValue [
	"Tells if the group is active or not.
	realValue will be used only if readBlock is not nil, in this case we will return block's value"

	^ readBlock ifNotNil: [ readBlock value ]
]

{ #category : 'accessing' }
PhLSettingsGroup >> realValue: aBoolean [

	"if aBoolean is true, that means that the group is active"
	
   writeBlock value: aBoolean.
]

{ #category : 'accessing' }
PhLSettingsGroup >> settingReceiver [

	^ self targetSelector
		  ifNil: [ self target ifNil: [ self defaultTarget ]]
		  ifNotNil: [ self target perform: self targetSelector ]
]

{ #category : 'building' }
PhLSettingsGroup >> with: aBlock [

	self asParentWhile: aBlock
]
