"
A parser that consumes nothing and always succeeds.
"
Class {
	#name : 'PPEpsilonParser',
	#superclass : 'PPParser',
	#category : 'PetitParser-Parsers',
	#package : 'PetitParser',
	#tag : 'Parsers'
}

{ #category : 'parsing' }
PPEpsilonParser >> parseOn: aStream [
	^ nil
]
