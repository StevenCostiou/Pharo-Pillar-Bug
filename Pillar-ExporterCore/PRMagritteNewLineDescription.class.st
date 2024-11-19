"
I am a description of a new line in Pillar.
"
Class {
	#name : 'PRMagritteNewLineDescription',
	#superclass : 'MAStringDescription',
	#category : 'Pillar-ExporterCore-Description',
	#package : 'Pillar-ExporterCore',
	#tag : 'Description'
}

{ #category : 'accessing' }
PRMagritteNewLineDescription class >> label [
	^ 'newLine'
]

{ #category : 'visiting' }
PRMagritteNewLineDescription >> acceptMagritte: aVisitor [
	aVisitor visitNewLineDescription: self
]
