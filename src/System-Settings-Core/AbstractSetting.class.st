"
I factor common slots between a Setting and a Setting Category.

Setting name must be unique among all settings managed by the same SettingManager.
"
Class {
	#name : 'AbstractSetting',
	#superclass : 'Object',
	#instVars : [
		'name',
		'label',
		'description',
		'order',
		'groupName',
		'group',
		'target',
		'targetSelector',
		'defaultValue',
		'declaration'
	],
	#category : 'System-Settings-Core-Base-New',
	#package : 'System-Settings-Core',
	#tag : 'Base-New'
}

{ #category : 'comparing' }
AbstractSetting >> = other [

	^ self species = other species 
		and: [ self name = other name ]
]

{ #category : 'visiting' }
AbstractSetting >> acceptSettings: aVisitor [
	^ aVisitor visitSettingDeclaration: self
]

{ #category : 'private' }
AbstractSetting >> builder [

	^ ActiveSettingBuilder value
]

{ #category : 'accessing' }
AbstractSetting >> declaration [
	
	^ declaration
]

{ #category : 'accessing' }
AbstractSetting >> declaration: aPragma [
	
	declaration := aPragma
]

{ #category : 'accessing' }
AbstractSetting >> defaultValue [

	^ defaultValue
]

{ #category : 'accessing' }
AbstractSetting >> defaultValue: aValue [

	defaultValue := aValue
]

{ #category : 'accessing' }
AbstractSetting >> description [
	"Answer the value of description"

	^ description
		ifNil: [ '' ]
		ifNotNil: [ description translated ]
]

{ #category : 'accessing' }
AbstractSetting >> description: aString [

	description := aString
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> dialog: anObject [

	self flag: 'What does mean a dialog for a group?'.
]

{ #category : 'accessing' }
AbstractSetting >> group [

	^ group
]

{ #category : 'accessing' }
AbstractSetting >> group: aSetting [

	group := aSetting
]

{ #category : 'accessing' }
AbstractSetting >> groupName [
	
	^ groupName
]

{ #category : 'accessing' }
AbstractSetting >> groupName: aSymbol [
	
	groupName := aSymbol
]

{ #category : 'testing' }
AbstractSetting >> hasDefault [
	
	^ self defaultValue notNil
]

{ #category : 'testing' }
AbstractSetting >> hasDefaultValue [

	^ self realValue = self defaultValue
]

{ #category : 'testing' }
AbstractSetting >> hasGroup [
	
	^ group isNotNil
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> hasValue [

	^ true
]

{ #category : 'comparing' }
AbstractSetting >> hash [

	^ self species hash bitXor: self name hash
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> iconName: aString [

	self flag: 'ToDo'
]

{ #category : 'testing' }
AbstractSetting >> isGroup [
	
	^ false
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> item [

	self 
		deprecated: 'Use self instead. #Pharo14'
		transformWith: '`@receiver item' -> '`@receiver'.
		
	^ self
]

{ #category : 'accessing' }
AbstractSetting >> label [

	^ label
		  ifNil: [ self name translated ]
		  ifNotNil: [ label translated ]
]

{ #category : 'accessing' }
AbstractSetting >> label: aString [

	label := aString
]

{ #category : 'accessing' }
AbstractSetting >> name [

	^ name ifNil: [ 'Unnamed ' , self class name ]
]

{ #category : 'accessing' }
AbstractSetting >> name: aName [

	name := aName asSymbol
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> noOrdering [

	self flag: 'ToDo'
]

{ #category : 'accessing' }
AbstractSetting >> order [

	^ order
]

{ #category : 'accessing' }
AbstractSetting >> order: aNumber [

	order := aNumber
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> parent: aSymbol [
	
	self 
		deprecated: 'Use #groupName: instead. #Pharo14'
		transformWith: '`@receiver parent: `@aSymbol' -> '`@receiver groupName: `@aSymbol'.

	self groupName: aSymbol
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> parentName: aSymbol [
	
	self 
		deprecated: 'Use #groupName: instead. #Pharo14'
		transformWith: '`@receiver parent: `@aSymbol' -> '`@receiver groupName: `@aSymbol'.

	self groupName: aSymbol
]

{ #category : 'printing' }
AbstractSetting >> printOn: aStream [

	aStream
		<< '['
		<< self className
		<< ': ';
		<< self name asString;
		<< ']'
]

{ #category : 'accessing' }
AbstractSetting >> settingIdentifier [
	"identifier is a string because it can contains many #"
	
	^ String streamContents: [ :aStream |
			self settingIdentifierOn: aStream ]
]

{ #category : 'printing' }
AbstractSetting >> settingIdentifierOn: aWriteStream [ 

	group
		ifNotNil: [ group settingIdentifierOn: aWriteStream ]
		ifNil: [ groupName ifNotNil: [ aWriteStream print: groupName ] ].
	aWriteStream print: self name
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> settingNodeIdentifier [
	
	self 
		deprecated: 'Use #defaultValue: instead. #Pharo14'
		transformWith: '`@receiver settingNodeIdentifier' -> '`@receiver settingIdentifier'.
		
	^ self settingIdentifier
]

{ #category : 'old setting builder compatibility' }
AbstractSetting >> settingNodeIdentifierOn: aWriteStream [ 

	self 
		deprecated: 'Use #settingIdentifierOn: instead. #Pharo14'
		transformWith: '`@receiver settingNodeIdentifierOn: `@aWriteStream' -> '`@receiver settingIdentifierOn: `@aWriteStream'
]

{ #category : 'accessing' }
AbstractSetting >> target [

	^ target
]

{ #category : 'accessing' }
AbstractSetting >> target: anObject [

	target := anObject
]

{ #category : 'accessing' }
AbstractSetting >> targetSelector [

	^ targetSelector
]

{ #category : 'accessing' }
AbstractSetting >> targetSelector: aSelector [

	targetSelector := aSelector
]
