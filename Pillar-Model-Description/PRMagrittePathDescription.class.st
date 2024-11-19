"
I am a magritte description of a Path.
"
Class {
	#name : 'PRMagrittePathDescription',
	#superclass : 'MAElementDescription',
	#category : 'Pillar-Model-Description',
	#package : 'Pillar-Model-Description'
}

{ #category : 'accessing' }
PRMagrittePathDescription class >> label [
	^ 'Path'
]

{ #category : 'visiting' }
PRMagrittePathDescription >> acceptMagritte: aVisitor [
	aVisitor visitPathDescription: self
]
