Extension { #name : 'MAVisitor' }

{ #category : '*Cocoon-Core-Description' }
MAVisitor >> visitConfigurationDescription: aConfigurationDescription [
	self visitElementDescription: aConfigurationDescription
]

{ #category : '*Cocoon-Core-Description' }
MAVisitor >> visitToManyRelationConfigurationDescription: aToManyRelationConfigurationDescription [
	self visitToManyRelationDescription: aToManyRelationConfigurationDescription
]

{ #category : '*Cocoon-Core-Description' }
MAVisitor >> visitToManyRelationFileDescription: aToManyRelationFileDescription [
	self visitToManyRelationDescription: aToManyRelationFileDescription
]

{ #category : '*Cocoon-Core-Description' }
MAVisitor >> visitToManyRelationFileMatchingDescription: aToManyRelationFileMatchingDescription [
	self visitToManyRelationDescription: aToManyRelationFileMatchingDescription
]
