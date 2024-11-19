Class {
	#name : 'MABasicObject',
	#superclass : 'GRObject',
	#category : 'Magritte-Model-Core',
	#package : 'Magritte-Model-Core'
}

{ #category : 'error handling' }
MABasicObject class >> defaultErrorClass [
	^ MAError 
]
