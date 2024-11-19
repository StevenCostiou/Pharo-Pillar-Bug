Extension { #name : 'ByteString' }

{ #category : '*PetitParser' }
ByteString >> asParser [
	"Answer a parser that accepts the receiving string."

	^ PPLiteralSequenceParser on: self
]
