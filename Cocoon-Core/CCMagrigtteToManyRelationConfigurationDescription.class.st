"
I am the Magritte description of a Collection of Cocoon configuration
"
Class {
	#name : 'CCMagrigtteToManyRelationConfigurationDescription',
	#superclass : 'MAToManyRelationDescription',
	#category : 'Cocoon-Core-Description',
	#package : 'Cocoon-Core',
	#tag : 'Description'
}

{ #category : 'accessing' }
CCMagrigtteToManyRelationConfigurationDescription class >> label [
	^ '1:m Configuration Relation'
]

{ #category : 'visitor' }
CCMagrigtteToManyRelationConfigurationDescription >> acceptMagritte: aVisitor [
	aVisitor visitToManyRelationConfigurationDescription: self
]
