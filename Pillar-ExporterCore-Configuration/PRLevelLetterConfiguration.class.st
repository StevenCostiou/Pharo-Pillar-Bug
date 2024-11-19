"
I'm a configuration that render myself as a Letter.
"
Class {
	#name : 'PRLevelLetterConfiguration',
	#superclass : 'PRTitleConfiguration',
	#category : 'Pillar-ExporterCore-Configuration',
	#package : 'Pillar-ExporterCore-Configuration'
}

{ #category : 'rendering-element' }
PRLevelLetterConfiguration >> renderElement: aNumber [
	| alphabet position |
	aNumber = 0 ifTrue: [ ^ 'NaN' ].
	
	alphabet := Character alphabet.
	position := aNumber \\ alphabet size.
	position = 0 ifTrue: [ position := alphabet size ].
	^ String
		streamContents: [ :s | 
			s nextPut: (alphabet at: position).
			((aNumber - 1) / alphabet size) asFloat floor timesRepeat: [ s nextPut: $' ] ]
]
