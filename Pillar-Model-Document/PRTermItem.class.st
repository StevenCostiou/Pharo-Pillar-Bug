"
A term
"
Class {
	#name : 'PRTermItem',
	#superclass : 'PRListItem',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'visiting' }
PRTermItem >> accept: aVisitor [
	aVisitor visitTermItem: self
]
