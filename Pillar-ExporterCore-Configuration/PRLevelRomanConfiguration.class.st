"
I'm a configuration that render myself as a Roman number.
"
Class {
	#name : 'PRLevelRomanConfiguration',
	#superclass : 'PRTitleConfiguration',
	#category : 'Pillar-ExporterCore-Configuration',
	#package : 'Pillar-ExporterCore-Configuration'
}

{ #category : 'rendering-element' }
PRLevelRomanConfiguration >> renderElement: aNumber [
	^ aNumber printStringRoman
]
