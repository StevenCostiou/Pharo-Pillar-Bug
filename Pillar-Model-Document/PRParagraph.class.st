"
I am a paragraph of text.
"
Class {
	#name : 'PRParagraph',
	#superclass : 'PRDocumentGroup',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'testing' }
PRParagraph class >> isAbstract [
	^ false
]

{ #category : 'visiting' }
PRParagraph >> accept: aVisitor [
	aVisitor visitParagraph: self
]
