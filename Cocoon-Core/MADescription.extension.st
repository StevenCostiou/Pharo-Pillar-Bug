Extension { #name : 'MADescription' }

{ #category : '*Cocoon-Core' }
MADescription >> cocoonDefaultDocumentation [
	"Answer the default documentation of the receiving description. This is use by Cocoon to generate documentation about default value"

	^ self propertyAt: #cocoonDefaultDocumentation ifAbsent: [ self class defaultCocoonDefaultDocumentation ]
]

{ #category : '*Cocoon-Core' }
MADescription >> cocoonDefaultDocumentation: aString [
	self propertyAt: #cocoonDefaultDocumentation put: aString
]

{ #category : '*Cocoon-Core' }
MADescription >> cocoonDocumentation [
	"Answer the documentation of the receiving description. This is use by Cocoon to generate documentation about  a parameter"

	^ self propertyAt: #cocoonDocumentation ifAbsent: [ self class defaultCocoonDocumentation ]
]

{ #category : '*Cocoon-Core' }
MADescription >> cocoonDocumentation: aString [
	self propertyAt: #cocoonDocumentation put: aString
]

{ #category : '*Cocoon-Core' }
MADescription class >> defaultCocoonDefaultDocumentation [
	^ nil
]

{ #category : '*Cocoon-Core' }
MADescription class >> defaultCocoonDocumentation [
	^ ''
]
