Extension { #name : 'ByteSymbol' }

{ #category : '*PetitParser-Core' }
ByteSymbol >> asParser [
	"Answer a parser that accepts the receiving character."
	
	^ PPLiteralObjectParser on: self
]
