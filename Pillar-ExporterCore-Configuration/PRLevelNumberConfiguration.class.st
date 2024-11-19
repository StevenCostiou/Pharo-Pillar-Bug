"
I'm a configuration that render myself as a Number.
"
Class {
	#name : 'PRLevelNumberConfiguration',
	#superclass : 'PRTitleConfiguration',
	#category : 'Pillar-ExporterCore-Configuration',
	#package : 'Pillar-ExporterCore-Configuration'
}

{ #category : 'rendering-element' }
PRLevelNumberConfiguration >> renderElement: aNumber [
	^ aNumber asString
]
