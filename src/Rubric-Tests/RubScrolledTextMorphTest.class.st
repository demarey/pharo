Class {
	#name : #RubScrolledTextMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'window',
		'textMorph',
		'textModel'
	],
	#category : #'Rubric-Tests-Base'
}

{ #category : #helpers }
RubScrolledTextMorphTest >> acceptButton [

	^ self acceptCancelRuler acceptButton
]

{ #category : #helpers }
RubScrolledTextMorphTest >> acceptCancelRuler [

	^ textMorph submorphs detect: [ :aMorph | 
		aMorph class = (textMorph classOfRulerNamed: RubAcceptCancelDisplayer key) ]
]

{ #category : #helpers }
RubScrolledTextMorphTest >> clickOn: aPluggableButtonMorph [

	| evt |
	evt := MouseButtonEvent new
		       setType: nil
		       position: aPluggableButtonMorph center
		       which: MouseButtonEvent redButton
		       buttons: MouseButtonEvent redButton
		       hand: nil
		       stamp: nil.

	(aPluggableButtonMorph handlesMouseDown: evt) ifTrue: [ 
		aPluggableButtonMorph 
			mouseDown: evt;
			mouseUp: evt ]
]

{ #category : #running }
RubScrolledTextMorphTest >> setUp [
	super setUp.
	textModel := RubScrolledTextModel new.
	textMorph := RubScrolledTextMorph on: textModel.
	textMorph extent: 400@250.
	textMorph setTextWith: 'one two three four'
]

{ #category : #running }
RubScrolledTextMorphTest >> tearDown [

	textMorph delete.
	window ifNotNil: [ :w | w delete ].
	super tearDown
]

{ #category : #tests }
RubScrolledTextMorphTest >> testAcceptCancelButtonsAreVisibleIfTextChanged [

	textMorph withAcceptCancel.
	window := textMorph openInWindow.
	
	textMorph textChanged.
	
	self assert: textMorph hasUnacceptedEdits.
	self assert: self acceptCancelRuler visible
]

{ #category : #tests }
RubScrolledTextMorphTest >> testAcceptCancelButtonsNotVisibleIfNoTextChange [

	textMorph withAcceptCancel.
	
	window := textMorph openInWindow.
	
	self deny: textMorph hasUnacceptedEdits.
	self deny: self acceptCancelRuler visible
]

{ #category : #tests }
RubScrolledTextMorphTest >> testCanAcceptWhenTextChanged [

	textMorph withAcceptCancel.
	window := textMorph openInWindow.
	textMorph textChanged.
	self assert: textMorph hasUnacceptedEdits.
	
	self clickOn: self acceptButton.
	
	self deny: textMorph hasUnacceptedEdits.
	self deny: self acceptCancelRuler visible
]

{ #category : #tests }
RubScrolledTextMorphTest >> testEmbeddedAnchorInTextAreDrawnAtRightPosition [
	| circle longTextWithCircleAtEnd canvas|
	self skip. "Test fail in CI"
	circle := CircleMorphCounter new extent: 50 @ 50;color: Color blue.
	longTextWithCircleAtEnd := ((String loremIpsum: 10000), 
		(String value: 1)) asText 
			addAttribute: (TextAnchor new anchoredMorph: circle).

	self assert: circle owner isNil.
	self assert: circle position equals: 0@0.
	textMorph updateTextWith: longTextWithCircleAtEnd.
	canvas := FormCanvas extent: 500@500.
	canvas fullDrawMorph: textMorph.
	
	self assert: circle owner equals: nil.
	self assert: circle counter equals: 0.
	
	textMorph scrollToEndOfText.	
	canvas := FormCanvas extent: 500@500.
	canvas fullDrawMorph: textMorph.
	self assert: circle counter > 0
]

{ #category : #tests }
RubScrolledTextMorphTest >> testGhostText [
	| scrolledText | 
	scrolledText := RubScrolledTextMorph new 
				ghostText: 'This is a cool ghost text';
				yourself.
	self assert: scrolledText ghostText string equals: 'This is a cool ghost text'
]
