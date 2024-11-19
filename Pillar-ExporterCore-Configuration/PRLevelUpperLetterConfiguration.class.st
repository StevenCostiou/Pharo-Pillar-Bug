"
I'm a configuration that render myself as an upper letter.
"
Class {
	#name : 'PRLevelUpperLetterConfiguration',
	#superclass : 'PRTitleConfiguration',
	#category : 'Pillar-ExporterCore-Configuration',
	#package : 'Pillar-ExporterCore-Configuration'
}

{ #category : 'rendering-element' }
PRLevelUpperLetterConfiguration >> renderElement: aNumber [
	| alphabet position |
	aNumber = 0 ifTrue: [ ^ 'NaN' ].
	
	alphabet := Character alphabet.
	position := aNumber \\ alphabet size.
	position = 0 ifTrue: [ position := alphabet size ].
	
	^ String
		streamContents: [ :s | 
			s nextPut: (alphabet at: position) asUppercase.
			((aNumber - 1) / alphabet size) asFloat floor
				timesRepeat: [ s nextPut: $' ] ]
]
