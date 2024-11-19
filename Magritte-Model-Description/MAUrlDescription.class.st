Class {
	#name : 'MAUrlDescription',
	#superclass : 'MAElementDescription',
	#category : 'Magritte-Model-Description',
	#package : 'Magritte-Model-Description'
}

{ #category : 'visiting' }
MAUrlDescription >> acceptMagritte: aVisitor [
	aVisitor visitUrlDescription: self
]
