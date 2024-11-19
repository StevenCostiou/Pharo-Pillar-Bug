"
I am a class that take a Cocoon Configuration and create a Dictionary with the Magritte descriptions from the configuration.
"
Class {
	#name : 'CCMagritteConfigurationReader',
	#superclass : 'MAVisitor',
	#instVars : [
		'baseDirectory',
		'configuration',
		'dictionary'
	],
	#category : 'Cocoon-Core-Configuration',
	#package : 'Cocoon-Core-Configuration'
}

{ #category : 'instance creation' }
CCMagritteConfigurationReader class >> writeConfiguration: aConf toDictionary: aDictionary [
	^ self new write: aConf to: aDictionary
]

{ #category : 'action' }
CCMagritteConfigurationReader >> completeConfiguration [
	"I'm here to add the input without description to the dictionary"

	configuration properties keysDo: [ :each | dictionary at: each put: (configuration properties at: each) ]
]

{ #category : 'action' }
CCMagritteConfigurationReader >> createDictionaryFrom: value [
	^ CCMagritteConfigurationReader writeConfiguration: value toDictionary: Dictionary new
]

{ #category : 'accessing' }
CCMagritteConfigurationReader >> pathOf: each [
	^ (each relativeTo: baseDirectory) printWithDelimiter: $/
]

{ #category : 'accessing' }
CCMagritteConfigurationReader >> readSelectorFor: aDescription [
	^ aDescription accessor readSelector
]

{ #category : 'visiting-description' }
CCMagritteConfigurationReader >> tryToAddFrom: aDescription withInterpretation: aBlock [
	"I take a description, check if the element describe by the description is on the Configuration, if I find it, I interpret it and I add it to the dictionary."

	| accessor |
	accessor := self readSelectorFor: aDescription.
	configuration properties
		at: accessor
		ifPresent: [ :value | 
			aDescription validate: value.
			dictionary at: accessor put: (aBlock value: value).
			configuration properties removeKey: accessor ]
]

{ #category : 'visiting-description' }
CCMagritteConfigurationReader >> visitConfigurationDescription: aConfigurationDescription [
	self tryToAddFrom: aConfigurationDescription withInterpretation: [ :value | self createDictionaryFrom: value ]
]

{ #category : 'visiting-description' }
CCMagritteConfigurationReader >> visitElementDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | value ]
]

{ #category : 'visiting-description' }
CCMagritteConfigurationReader >> visitFileDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | self pathOf: value ]
]

{ #category : 'visiting-description' }
CCMagritteConfigurationReader >> visitToManyRelationConfigurationDescription: aToManyRelationConfigurationDescription [
	self
		tryToAddFrom: aToManyRelationConfigurationDescription
		withInterpretation:
			[ :value | | collection |
			collection := Dictionary new.
			value
				do:
					[ :each | collection at: each configurationName put: (self createDictionaryFrom: each) ].
			collection ]
]

{ #category : 'visiting-description' }
CCMagritteConfigurationReader >> visitToManyRelationFileDescription: aToManyRelationFileDescription [
	self
		tryToAddFrom: aToManyRelationFileDescription
		withInterpretation: [ :value | 
			| index |
			index := 1.
			value
				do: [ :each | 
					value at: index put: (self pathOf: each).
					index := index + 1 ].
			value ]
]

{ #category : 'action' }
CCMagritteConfigurationReader >> write: aConfiguration to: aDictionary [
	"I write the content of a Configuration to a Dictionary following a Magritte Description."

	configuration := aConfiguration.
	dictionary := aDictionary.
	baseDirectory := aConfiguration baseDirectory.
	aConfiguration magritteDescription children
		detect: [ :each | each accessor readSelector = 'baseDirectory' ]
		ifFound: [ :description | self visitDirectoryDescription: description ].	"We do that in order to have the base directory to interprete the files later."
	self visitAll: aConfiguration magritteDescription children.	"We rebuild the description because the default directory might have changed."
	self visitAll: aConfiguration magritteDescription children.
	self completeConfiguration.
	^ dictionary
]
