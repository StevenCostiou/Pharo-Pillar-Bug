"
I am the Magritte description of a Script Language.
"
Class {
	#name : 'PRMagritteScriptLanguageDescription',
	#superclass : 'MAElementDescription',
	#category : 'Pillar-ExporterCore-Description',
	#package : 'Pillar-ExporterCore',
	#tag : 'Description'
}

{ #category : 'accessing' }
PRMagritteScriptLanguageDescription class >> label [
	^ 'Script Language'
]

{ #category : 'visiting' }
PRMagritteScriptLanguageDescription >> acceptMagritte: aVisitor [
	aVisitor visitScriptLanguageDescription: self
]
