Extension { #name : 'ByteSymbol' }

{ #category : '*PetitParser' }
ByteSymbol >> asParser [
	"Answer a parser that accepts the receiving character."
	
	^ PPLiteralObjectParser on: self
]
