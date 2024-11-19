Extension { #name : 'Object' }

{ #category : '*magritte-model-model' }
Object >> initializeMagritte [
	"Initializes the receiving object with the default values of its description."

	self magritteDescription do: [ :each |
		each isReadonly
			ifFalse: [ self write: each default using: each ] ]
]

{ #category : '*magritte-model-model' }
Object >> readUsing: aDescription [
	"Dispatch the read-access to the receiver using the accessor of aDescription."

	^ aDescription accessor read: self
]

{ #category : '*magritte-model-model' }
Object >> write: anObject using: aDescription [
	"Dispatch the write-access to the receiver of anObject using the accessor of aDescription."

	aDescription accessor write: anObject to: self
]
