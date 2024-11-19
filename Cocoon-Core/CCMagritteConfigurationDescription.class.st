"
I am the Magritte description of a cocoon configuration.
"
Class {
	#name : 'CCMagritteConfigurationDescription',
	#superclass : 'MAElementDescription',
	#category : 'Cocoon-Core-Description',
	#package : 'Cocoon-Core',
	#tag : 'Description'
}

{ #category : 'accessing' }
CCMagritteConfigurationDescription class >> label [
	^ 'Configuration'
]

{ #category : 'visiting' }
CCMagritteConfigurationDescription >> acceptMagritte: aVisitor [
	aVisitor visitConfigurationDescription: self
]
