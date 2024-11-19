"
I am the Magritte description of a collection of files.
"
Class {
	#name : 'CCMagritteToManyRelationFileDescription',
	#superclass : 'MAToManyRelationDescription',
	#category : 'Cocoon-Core-Description',
	#package : 'Cocoon-Core',
	#tag : 'Description'
}

{ #category : 'accessing' }
CCMagritteToManyRelationFileDescription class >> label [
	^ '1:m File Relation'
]

{ #category : 'visiting' }
CCMagritteToManyRelationFileDescription >> acceptMagritte: aVisitor [
	aVisitor visitToManyRelationFileDescription: self
]

{ #category : 'file system' }
CCMagritteToManyRelationFileDescription >> defaultDirectory [

	^ self propertyAt: #defaultDirectory ifAbsent: [ MAFileSystem imageDirectory ].
]

{ #category : 'accessing' }
CCMagritteToManyRelationFileDescription >> defaultDirectory: fileReference [
	"fileReference - a FileSystem FileReference, or an MAFileReference if FileSystem is not installed"

	self propertyAt: #defaultDirectory put: fileReference
]
