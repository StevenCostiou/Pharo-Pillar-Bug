"
I am a Maggrite description to a collection of file. I have a different visitor that CCMagritteToManyRelationFileDescription because during the visit I can match some files with a description as '**/*.st'.

As the CCMagritteToManyRelationFileDescription I will contains I describe a collection of file but for Cocoon we need two different visitor.
"
Class {
	#name : 'CCMagritteToManyRelationFileMatchingDescription',
	#superclass : 'CCMagritteToManyRelationFileDescription',
	#category : 'Cocoon-Core-Description',
	#package : 'Cocoon-Core',
	#tag : 'Description'
}

{ #category : 'visiting' }
CCMagritteToManyRelationFileMatchingDescription >> acceptMagritte: aVisitor [
	aVisitor visitToManyRelationFileMatchingDescription: self
]
