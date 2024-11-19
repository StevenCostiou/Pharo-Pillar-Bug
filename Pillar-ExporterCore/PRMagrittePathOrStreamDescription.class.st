"
I am a path or WriteStream description for Pillar.
"
Class {
	#name : 'PRMagrittePathOrStreamDescription',
	#superclass : 'MAElementDescription',
	#category : 'Pillar-ExporterCore-Description',
	#package : 'Pillar-ExporterCore',
	#tag : 'Description'
}

{ #category : 'accessing-defaults' }
PRMagrittePathOrStreamDescription class >> defaultKind [
	^ Path
]

{ #category : 'visiting' }
PRMagrittePathOrStreamDescription >> acceptMagritte: aVisitor [
	aVisitor visitPathOrStreamDescription: self
]

{ #category : 'accessing' }
PRMagrittePathOrStreamDescription >> secondKind [
	^ WriteStream
]

{ #category : 'validation-private' }
PRMagrittePathOrStreamDescription >> validateKind: anObject [
	"Validate ==anObject== to be of the right kind."

	((anObject isKindOf: self kind) or: [anObject isKindOf: self secondKind])
		ifFalse: [ MAKindError description: self signal: self kindErrorMessage ]
]
