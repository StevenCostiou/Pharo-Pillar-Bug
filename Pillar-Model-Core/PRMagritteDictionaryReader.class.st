"
I read a dictionary which the values are all strings and I return a new dictionary with the descriptions of an annotation.

dictionary is my input dictionary.
annotationDictionary is the new dictionary I'm building.
class is the class of the annotation.
"
Class {
	#name : 'PRMagritteDictionaryReader',
	#superclass : 'MAVisitor',
	#instVars : [
		'dictionary',
		'annotationDictionary',
		'class'
	],
	#category : 'Pillar-Model-Core',
	#package : 'Pillar-Model-Core'
}

{ #category : 'instance creation' }
PRMagritteDictionaryReader class >> writeDictionary: aCollection for: anAnnotationClass [
	^ self new
		class: anAnnotationClass;
		write: aCollection
]

{ #category : 'visiting-description' }
PRMagritteDictionaryReader >> checkRequired: accessor with: aDescription [
	^ aDescription required
		ifTrue: [ PRPropertyError signal: accessor , ' is a required parameter on a ' , class tag , ' annotation' ]
]

{ #category : 'accessing' }
PRMagritteDictionaryReader >> class: anObject [
	class := anObject
]

{ #category : 'action' }
PRMagritteDictionaryReader >> interpretAsBoolean: value with: aDescription [
	'true' = value
		ifTrue: [ ^ true ].
	'false' = value
		ifTrue: [ ^ false ].
	PRError
		signal: aDescription accessor readSelector , ' must be a boolean in ' , class tag , ' annotation. Receive : ' , value
]

{ #category : 'action' }
PRMagritteDictionaryReader >> interpretAsNumber: value with: aDescription [
	value
		do: [ :each | 
			each isDigit
				ifFalse: [ 
					PRError
						signal:
							aDescription accessor readSelector , ' must be a number in ' , class tag , ' annotation. Receive : ' , value ] ].
	^ value asNumber
]

{ #category : 'action' }
PRMagritteDictionaryReader >> raiseWarningIfTooManyParameters [
	dictionary isEmpty
		ifFalse: [ 
			dictionary keys
				do: [ :key | PRWarning signal: key , ' is not a valid parameter for a ' , class tag , ' annotation. This will be ignore.' ] ]
]

{ #category : 'action' }
PRMagritteDictionaryReader >> sortDescriptions [
	"I sort the descriptions to keep the order on the parameters for the Pillar exporter. If one day the Pillar export become a normalizer and not an exact expoter, just return ==class new magritteDescription children=="

	| sortedDescriptions descriptions |
	descriptions := class new magritteDescription children.
	sortedDescriptions := OrderedCollection new.
	dictionary keys
		do: [ :key | 
			descriptions copy
				do: [ :description | 
					description accessor readSelector = key
						ifTrue: [ 
							sortedDescriptions add: description.
							descriptions remove: description ] ] ].
	descriptions do: [ :each | sortedDescriptions add: each ].	"I add the rest of the descriptions to check if all required parameters are present."
	^ sortedDescriptions
]

{ #category : 'visiting-description' }
PRMagritteDictionaryReader >> tryToAddFrom: aDescription withInterpretation: aBlock [
	"I take a Description, check if an object of the dictionary match with the description, if I find one, I interpret it and add it to the new dictionary."

	| accessor value |
	accessor := aDescription accessor selector.
	((dictionary includesKey: accessor) not and: [ aDescription default isNil ])
		ifTrue: [ ^ self checkRequired: accessor with: aDescription].

	value := dictionary at: accessor
		ifPresent: aBlock
		ifAbsent: [ aDescription default ].
	
	aDescription validate: value.
	annotationDictionary at: accessor put: value.
	dictionary removeKey: accessor ifAbsent: [  ].
]

{ #category : 'visiting-description' }
PRMagritteDictionaryReader >> visitBooleanDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | self interpretAsBoolean: value with: aDescription ]
]

{ #category : 'visiting-description' }
PRMagritteDictionaryReader >> visitElementDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | value ]
]

{ #category : 'visiting-description' }
PRMagritteDictionaryReader >> visitNumberDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | self interpretAsNumber: value with: aDescription ]
]

{ #category : 'visiting-description' }
PRMagritteDictionaryReader >> visitPathDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | Path from: value ]
]

{ #category : 'action' }
PRMagritteDictionaryReader >> write: aCollection [
	| descriptions |
	dictionary := aCollection.
	descriptions := self sortDescriptions.
	annotationDictionary := aCollection class new.
	self visitAll: descriptions.
	self raiseWarningIfTooManyParameters.
	^ annotationDictionary
]
