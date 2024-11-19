Extension { #name : 'Symbol' }

{ #category : '*magritte-model-converting' }
Symbol >> asAccessor [
	^ MASelectorAccessor selector: self
]
