Extension { #name : 'Character' }

{ #category : '*PetitParser-Core' }
Character >> asParser [
	"Answer a parser that accepts the receiving character."
	
	^ PPLiteralObjectParser on: self
]
