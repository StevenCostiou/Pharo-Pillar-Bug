"
I am a class that take a Dictionary and create a Cocoon Configuration with the Magritte descriptions from the configuration.
"
Class {
	#name : 'CCMagritteDictionaryReader',
	#superclass : 'MAVisitor',
	#instVars : [
		'dictionary',
		'configuration'
	],
	#category : 'Cocoon-Core-Configuration',
	#package : 'Cocoon-Core-Configuration'
}

{ #category : 'instance-creation' }
CCMagritteDictionaryReader class >> writeDictionary: aCollection toConfiguration: aConf [
	^ self new write: aCollection to: aConf
]

{ #category : 'action' }
CCMagritteDictionaryReader >> completeConfiguration [
	"I'm here to add the input without description to the configuration"

	dictionary
		keysDo: [ :each | 
			| accessor |
			accessor := each , ':'.
			configuration perform: accessor with: (dictionary at: each) ]
]

{ #category : 'action' }
CCMagritteDictionaryReader >> createConfigurationFrom: anAssociation [
	| config |
	config := configuration class new
		configurationName: anAssociation key;
		parent: configuration;
		yourself.
	^ self class writeDictionary: anAssociation value toConfiguration: config
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> directoriesFor: path from: dirs [
	| directories |
	directories := Set new.
	path first = '**'
		ifTrue:
			[ 
			dirs
				do:
					[ :dir | directories addAll: (dir allDirectoriesMatching: path first) ] ]
		ifFalse:
			[ 
			dirs
				do:
					[ :dir | directories addAll: (dir directoriesMatching: path first) ] ].
	^ directories
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> extractSubFolderContentsInto: aCollection [
	| temp |
	temp := aCollection copy.
	temp
		do: [ :each | 
			each isDirectory
				ifTrue: [ aCollection addAll: (CollectVisitor breadthFirst: each collect: [ :file | file asFileReference ]) ] ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> filesMatching: regexPath [
	| path result dirs |
	self flag: #todo. "Latter the user should be able to reject some files with a annotation as '- *.pillar'"
	path := regexPath splitOn: $/.
	result := Set new.
	dirs := OrderedCollection with: configuration baseDirectory.	"We begin to search from the base directory."
	[ path size = 1 ]
		whileFalse:
			[ 
			dirs := self directoriesFor: path from: dirs.
			path removeFirst ].
	dirs do:
		[ :dir | result addAll: (dir childrenMatching: path first) ].
	^ result
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> resolve: path with: aDescription [
	^ path class = FileReference
		ifTrue: [ path ]
		ifFalse: [ 
			| file |
			file := configuration baseDirectory resolve: path.
			file exists
				ifFalse: [ CCConfigurationError signal: path , ' is not a valid file name into ' , configuration baseDirectory asString , '.' ].
			file ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> resolveDirectory: aPath [
	"If you want the Directory to exist add "

	"addCondition: [ :dir | directory exists and: [ directory isDirectory ] ]"

	" to the description."

	^ configuration baseDirectory resolve: aPath
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> tryToAddFrom: aDescription withInterpretation: aBlock [
	"I take a Description, check if an object of the dictionary match with the description, if I find one, I interpret it and add it to the configuration."

	| accessor |
	accessor := aDescription accessor selector.
	dictionary
		at: accessor
		ifPresent: [ :value | 
			| newValue |
			newValue := aBlock value: value.
			aDescription validate: newValue.
			dictionary removeKey: accessor.
			configuration write: newValue using: aDescription ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> visitConfigurationDescription: aConfigurationDescription [
	self
		tryToAddFrom: aConfigurationDescription
		withInterpretation:
			[ :value | self createConfigurationFrom: configuration defaultConfigurationName -> value ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> visitDirectoryDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | self resolveDirectory: value ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> visitElementDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | value ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> visitFileDescription: aDescription [
	self tryToAddFrom: aDescription withInterpretation: [ :value | self resolve: value with: aDescription ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> visitToManyRelationConfigurationDescription: aToManyRelationConfigurationDescription [
	self
		tryToAddFrom: aToManyRelationConfigurationDescription
		withInterpretation:
			[ :collection | | configurations |
			configurations := OrderedCollection new.
			collection associationsDo: [ :value | configurations add: (self createConfigurationFrom: value) ].
			configurations ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> visitToManyRelationFileDescription: aToManyRelationFileDescription [
	self
		tryToAddFrom: aToManyRelationFileDescription
		withInterpretation: [ :collection | 
			| index |
			index := 1.
			collection
				do: [ :value | 
					collection at: index put: (self resolve: value with: aToManyRelationFileDescription).
					index := index + 1 ].
			collection ]
]

{ #category : 'visiting-description' }
CCMagritteDictionaryReader >> visitToManyRelationFileMatchingDescription: aToManyRelationFileMatchingDescription [
	self
		tryToAddFrom: aToManyRelationFileMatchingDescription
		withInterpretation: [ :collection | 
			| result |
			result := Set new.
			collection do: [ :path | result addAll: (self filesMatching: path) ].
			self extractSubFolderContentsInto: result.
			result ]
]

{ #category : 'action' }
CCMagritteDictionaryReader >> write: aDictionary to: aConfiguration [
	dictionary := aDictionary.
	configuration := aConfiguration.
	aDictionary
		at: 'baseDirectory'
		ifPresent: [ :elem | 
			aConfiguration baseDirectory: elem.
			aDictionary removeKey: 'baseDirectory' ].
	self visitAll: aConfiguration magritteDescription children.	"We rebuild the description because the default directory might have changed."
	self completeConfiguration.
	^ configuration
]
