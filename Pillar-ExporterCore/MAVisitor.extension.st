Extension { #name : 'MAVisitor' }

{ #category : '*Pillar-ExporterCore' }
MAVisitor >> visitHeaderLevelDescription: aHeaderLevelDescription [
	self visitToOneRelationDescription: aHeaderLevelDescription
]

{ #category : '*Pillar-ExporterCore' }
MAVisitor >> visitNewLineDescription: aNewLineDescription [
	self visitStringDescription: aNewLineDescription
]

{ #category : '*Pillar-ExporterCore' }
MAVisitor >> visitPathOrStreamDescription: aPathOrStreamDescription [
	self visitElementDescription: aPathOrStreamDescription
]

{ #category : '*Pillar-ExporterCore' }
MAVisitor >> visitScriptLanguageDescription: aScriptLanguageDescription [
	self visitElementDescription: aScriptLanguageDescription
]
