Extension { #name : 'Symbol' }

{ #category : '*magritte-model-description' }
Symbol >> optionFor: anObject ifPresent: aBlock [
	aBlock value: (anObject perform: self)
]
