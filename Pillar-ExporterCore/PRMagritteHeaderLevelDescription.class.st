"
I am the Magritte description of a header level.
"
Class {
	#name : 'PRMagritteHeaderLevelDescription',
	#superclass : 'MAToOneRelationDescription',
	#category : 'Pillar-ExporterCore-Description',
	#package : 'Pillar-ExporterCore',
	#tag : 'Description'
}

{ #category : 'accessing-defaults' }
PRMagritteHeaderLevelDescription class >> defaultLevel [
	^ 1
]

{ #category : 'accessing' }
PRMagritteHeaderLevelDescription class >> label [
	^ 'Header level description'
]

{ #category : 'visiting' }
PRMagritteHeaderLevelDescription >> acceptMagritte: aVisitor [
	aVisitor visitHeaderLevelDescription: self
]

{ #category : 'accessing' }
PRMagritteHeaderLevelDescription >> level [
	^ self propertyAt: #level ifAbsent: [ self class defaultLevel ]
]

{ #category : 'accessing' }
PRMagritteHeaderLevelDescription >> level: anObject [
	self propertyAt: #level put: anObject
]
