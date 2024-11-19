Extension { #name : 'ByteString' }

{ #category : '*PetitParser-Core' }
ByteString >> asParser [
	"Answer a parser that accepts the receiving string."

	^ PPLiteralSequenceParser on: self
]
