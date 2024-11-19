Extension { #name : 'Object' }

{ #category : '*magritte-model-accessing' }
Object >> basicMagritteDescription [
	^ MAPragmaBuilder for: self
]

{ #category : '*magritte-model-accessing' }
Object >> descriptionContainer [
	"Return the default description container."
	<magritteContainer>
	^ MAPriorityContainer new
		label: self class label;
		yourself
]

{ #category : '*magritte-model-accessing' }
Object >> magritteDescription [
	^ self basicMagritteDescription
]

{ #category : '*magritte-model-accessing' }
Object >> mementoClass [
	"Return a class to be used to remember or cache the receiver, namely a memento object."

	^ MACheckedMemento
]
