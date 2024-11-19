"
I am a structure representation.
"
Class {
	#name : 'PRStructure',
	#superclass : 'PRDocumentItem',
	#instVars : [
		'tag',
		'structDict'
	],
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'testing' }
PRStructure class >> isAbstract [
	^false
]

{ #category : 'visiting' }
PRStructure >> accept: aVisitor [
	aVisitor visitStructure: self
]

{ #category : 'accesing' }
PRStructure >> structDict [
	^ structDict ifNil: [ Dictionary new ]
]

{ #category : 'accesing' }
PRStructure >> structDict: aDictionary [
	structDict := aDictionary
]

{ #category : 'accesing' }
PRStructure >> tag [
 ^ 	tag ifNil: [ 'default' ]
]

{ #category : 'accesing' }
PRStructure >> tag: aTag [
	tag := aTag
]
