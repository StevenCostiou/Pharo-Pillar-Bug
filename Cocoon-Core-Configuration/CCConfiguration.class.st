"
I am a class managing configuration used  by an application.
In fact I managed a set of properties. 
I am implementing a composite pattern since a configuration can contain other sub-configurations.
Information not found in a configuration is looked up in its parent (and it's done recursively).

I have a Dictionnary call 'properties' which contains the properties of the configuration. 
On CCConfiguration I contains the 'baseDirectory' where to search the config and a collection of configurations call 'configurations'. 

I stock the magritte descriptions to not have to rebuild them all the time.
 
For create a new Configuration you need to extands CCConfiguration. 
In your XXCocoonConfiguration's class you'll need to define new properties with a Magritte Description. 
For example if you need some input files you can create this method : 

descriptionInputFiles
	<magritteDescription>
	^ CCMagritteToManyRelationFileDescription new
		defaultDirectory: self baseDirectory;
		priority: 100;
		accessor: #inputFiles;
		label:
				'Input files to export.';
		cocoonDocumentation: 'List the Pillar files that must be exported (can be a FileReference, a relative path from baseDirectory or an absolute path).';
		classes: {FileReference};
		default: Array new;
		yourself

"
Class {
	#name : 'CCConfiguration',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'properties',
		'magritteDescription',
		'configurationName'
	],
	#category : 'Cocoon-Core-Configuration',
	#package : 'Cocoon-Core-Configuration'
}

{ #category : 'instance creation' }
CCConfiguration class >> newFromDictionary: aSTONDictionary [
	^ self reader writeDictionary: aSTONDictionary toConfiguration: self new
]

{ #category : 'instance creation' }
CCConfiguration class >> newFromDictionary: aSTONDictionary extendedWith: anOtherDictionary [
	^ self reader writeDictionary: aSTONDictionary , anOtherDictionary toConfiguration: self new
]

{ #category : 'instance creation' }
CCConfiguration class >> newFromFile: aFile [
	^ aFile readStreamDo: [ :input | self newFromStream: input ]
]

{ #category : 'instance creation' }
CCConfiguration class >> newFromFile: aFile extendedWith: anOtherDictionary [
	^ aFile readStreamDo: [ :input | self newFromStream: input extendedWith: anOtherDictionary ]
]

{ #category : 'instance creation' }
CCConfiguration class >> newFromStream: aStream [
	^ [ self newFromDictionary: (STON fromStream: aStream) ]
		on: STONReaderError
		do: [ :error | CCConfigurationError signal: error messageText ]
]

{ #category : 'instance creation' }
CCConfiguration class >> newFromStream: aStream extendedWith: anOtherDictionary [
	^ [ self newFromDictionary: (STON fromStream: aStream) extendedWith: anOtherDictionary ]
		on: STONReaderError
		do: [ :error | CCConfigurationError signal: error messageText ]
]

{ #category : 'instance creation' }
CCConfiguration class >> newFromString: aString [
	^ self newFromStream: aString readStream
]

{ #category : 'instance creation' }
CCConfiguration class >> newFromString: aString extendedWith: anOtherDictionary [
	^ self newFromStream: aString readStream extendedWith: anOtherDictionary
]

{ #category : 'accessors' }
CCConfiguration class >> reader [
	^ CCMagritteDictionaryReader
]

{ #category : 'comparing' }
CCConfiguration >> = anObject [
	^ self species = anObject species and: [ self properties = anObject properties and: [ self parent = anObject parent and: [ self configurationName = anObject configurationName ] ] ]
]

{ #category : 'accessing - properties' }
CCConfiguration >> allProperties [
	"Answer all properties of the receiver and its parents."

	| parentProperties |
	parentProperties := self hasParent
		ifTrue: [ self parent allProperties ]
		ifFalse: [ Dictionary new ].
	parentProperties addAll: self properties.
	^ parentProperties
]

{ #category : 'accessing' }
CCConfiguration >> baseDirectory [
	^ self propertyAt: 'baseDirectory' default: [ self defaultBaseDirectory ]
]

{ #category : 'accessing' }
CCConfiguration >> baseDirectory: aDirectory [
	"Set the directory where to look for the file with non-absolute path or a Directory as FileReference."

	self propertyAt: 'baseDirectory' put: (self toDirectory: aDirectory)
]

{ #category : 'accessing' }
CCConfiguration >> configurationName [
	^ configurationName ifNil: [ self defaultConfigurationName ]
]

{ #category : 'accessing' }
CCConfiguration >> configurationName: anObject [
	configurationName := anObject
]

{ #category : 'accessing' }
CCConfiguration >> configurations [
	^ self propertyAt: 'configurations' ifAbsent: [ self defaultValueOf: #configurations ]
]

{ #category : 'accessing defaults' }
CCConfiguration >> defaultBaseDirectory [
	"The current working directory"

	^ FileSystem workingDirectory
]

{ #category : 'accessing defaults' }
CCConfiguration >> defaultConfigurationName [
	^ 'Default Configuration'
]

{ #category : 'accessing defaults' }
CCConfiguration >> defaultValueOf: propertySelector [
	^ self magritteDescription children
		detect: [ :e | e accessor readSelector = propertySelector ]
		ifFound: [ :description | description default ]
		ifNone: [ 
			CCConfigurationError
				signal:
					'No default value for ' , propertySelector , '. Please add a default value on ' , self class asString
						, ' or add a value on the configuration.' ]
]

{ #category : 'descriptions' }
CCConfiguration >> descriptionBaseDirectory [
	<magritteDescription>
	^ MADirectoryDescription new
		accessor: #baseDirectory;
		priority: 0;
		label: 'Cocoon base directory';
		cocoonDocumentation: 'Indicate where to look for files.';
		cocoonDefaultDocumentation: 'The current working directory';
		default: self defaultBaseDirectory;
		kind: FileReference;
		addCondition: [ :value | value exists and: [ value isDirectory ] ];
		yourself
]

{ #category : 'descriptions' }
CCConfiguration >> descriptionConfigurations [
	<magritteDescription>
	^ CCMagrigtteToManyRelationConfigurationDescription new
		accessor: #configurations;
		priority: 100;
		label: 'Subconfigurations of Cocoon.';
		cocoonDocumentation:
			'Each configuration can define several sub configurations, each of which inherits the properties of its parent.';
		classes: {self class};
		cocoonDefaultDocumentation: 'A dictionary of default configurations from the exporters.';
		default: Dictionary new;
		yourself
]

{ #category : 'reflective operations' }
CCConfiguration >> doesNotUnderstand: aMessage [
	"I allow to get or set property of the configuration."

	^ aMessage arguments size = 1
		ifTrue: [ 
			self magritteDescription children
				detect: [ :each | each accessor writeSelector = aMessage selector ]
				ifFound: [ :description | description validate: aMessage argument ].
			self properties at: aMessage selector allButLast put: aMessage argument ]
		ifFalse: [ 
			[ self propertyAt: aMessage selector ]
				on: PropertyError
				do: [ self defaultValueOf: aMessage selector ] ]
]

{ #category : 'private' }
CCConfiguration >> error: aString [
	^ CCConfigurationError signal: aString
]

{ #category : 'private' }
CCConfiguration >> errorPropertyNotFound: aSelector [
	"Error on a property"
	
	PropertyError signal: 'Property ' , aSelector , ' not found.'
]

{ #category : 'testing' }
CCConfiguration >> hasParent [
	^ parent notNil
]

{ #category : 'testing' }
CCConfiguration >> hasProperty: aKey [
	"Test if the property ==aKey== is defined within the receiver."

	^ self properties includesKey: aKey
]

{ #category : 'comparing' }
CCConfiguration >> hash [
	^ self species hash bitXor: (self properties hash bitXor: (self parent hash bitXor: self configurationName hash))
]

{ #category : 'accessing - properties' }
CCConfiguration >> inheritsPropertyAt: aKey [
	"Answer true iff I (or one of my ancestors) contain a property named ==aKey==."

	^ self
		propertyAt: aKey
		ifPresent: [:value | true ]
		ifAbsent:
			[ 
			self hasParent
				ifTrue: [ self parent inheritsPropertyAt: aKey ]
				ifFalse: [ false ] ]
]

{ #category : 'private' }
CCConfiguration >> log: aString [
	self verbose
		ifTrue: [ 
			FileStream stderr
				<< aString;
				cr ]
]

{ #category : 'accessing' }
CCConfiguration >> magritteDescription [
	"If the magritte description is nil I create it and I store it."

	^ magritteDescription ifNil: [ magritteDescription := self basicMagritteDescription ]
]

{ #category : 'accessing' }
CCConfiguration >> magritteDescription: anObject [
	magritteDescription := anObject.
	^ magritteDescription
]

{ #category : 'accessing' }
CCConfiguration >> parent [
	"A parent is a Configuration I extends"
	
	^ parent
]

{ #category : 'accessing' }
CCConfiguration >> parent: aConfiguration [
	parent := aConfiguration
]

{ #category : 'copying' }
CCConfiguration >> postCopy [
	"I'm a hook method in the sense of Design Patterns TemplateHook/Methods. I'm called by copy. self is a shallow copy, subclasses should copy fields as necessary to complete the full copy"
	super postCopy.
	properties := properties copy
]

{ #category : 'printing' }
CCConfiguration >> printOn: aStream [
	<ignoreForCoverage>
	super printOn: aStream.
	aStream
		nextPut: $[;
		nextPutAll: self configurationName;
		nextPut: $-;
		print: self identityHash;
		nextPut: $]
]

{ #category : 'accessing - properties' }
CCConfiguration >> properties [
	"Answer the property dictionary of the receiver."

	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : 'accessing - properties' }
CCConfiguration >> propertyAt: aKey [
	"Answer the value of the property ==aKey==, raises an error if the property doesn't exist."

	^ self propertyAt: aKey ifAbsent: [ 
		self hasParent
			ifTrue: [ self parent propertyAt: aKey ]
			ifFalse: [self errorPropertyNotFound: aKey ]]
]

{ #category : 'accessing - properties' }
CCConfiguration >> propertyAt: aKey default: aBlock [
	"Answer the value of ==aKey==. If the key have no entry I look on the parent or execute a block if i'm an orphan."

	^ self
		propertyAt: aKey
		ifAbsent: [ 
			self hasParent
				ifTrue: [ self parent propertyAt: aKey default: aBlock ]
				ifFalse: aBlock ]
]

{ #category : 'accessing - properties' }
CCConfiguration >> propertyAt: aKey ifAbsent: aBlock [
	"Answer the value of the property ==aKey==, or the result of ==aBlock== if the property doesn't exist."

	^ self properties at: aKey ifAbsent: aBlock
]

{ #category : 'accessing - properties' }
CCConfiguration >> propertyAt: aKey ifAbsentPut: aBlock [
	"Answer the value of the property ==aKey==, or if the property doesn't exist adds and answers the result of evaluating ==aBlock==."

	^ self properties at: aKey ifAbsentPut: aBlock
]

{ #category : 'accessing - properties' }
CCConfiguration >> propertyAt: aKey ifPresent: presentBlock ifAbsent: absentBlock [
	"Answer the result of ==presentBlock== if I have the property ==aKey== or the result of ==absentBlock==."

	^ self properties at: aKey ifPresent: presentBlock ifAbsent: absentBlock
]

{ #category : 'accessing - properties' }
CCConfiguration >> propertyAt: aKey put: aValue [
	"Adds or replaces the property ==aKey== with ==aValue==."

	^ self properties at: aKey put: aValue
]

{ #category : 'accessing' }
CCConfiguration >> subConfigurationNamed: aString [
	"I return a configuration of the name 'aString'. If this configuration doesn't exist i raise an error."

	^ self configurations
		detect: [ :each | each configurationName = aString ]
		ifNone:
			[ self configurations
				do: [ :conf | (conf subConfigurationNamed: aString) ifNotNil: [ :subsub | ^ subsub ] ].
			nil ]
]

{ #category : 'private' }
CCConfiguration >> toDirectory: aDirectory [
	"I return a FileReference that corresponds to aDirectory."

	| directory |
	directory := self baseDirectory resolve: aDirectory.
	^ (directory exists and: [ directory isDirectory ])
		ifTrue: [ directory ]
		ifFalse: [ self error: aDirectory asString , ' is not a valid directory.' ]
]
