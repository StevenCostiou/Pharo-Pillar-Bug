"
I manage pillar specific configuration.
"
Class {
	#name : 'PRPillarConfiguration',
	#superclass : 'CCConfiguration',
	#instVars : [
		'disabledPhases'
	],
	#classVars : [
		'HeaderConfigurations'
	],
	#category : 'Pillar-ExporterCore-Configuration',
	#package : 'Pillar-ExporterCore-Configuration'
}

{ #category : 'accessing' }
PRPillarConfiguration class >> defaultHeaderConfigurations [
	^ Dictionary
		with: 'number' -> PRLevelNumberConfiguration
		with: 'roman' -> PRLevelRomanConfiguration
		with: 'letter' -> PRLevelLetterConfiguration
		with: 'upperLetter' -> PRLevelUpperLetterConfiguration yourself
]

{ #category : 'accessing' }
PRPillarConfiguration class >> headerConfigurations [
	^ HeaderConfigurations ifNil: [ HeaderConfigurations := self defaultHeaderConfigurations ]
]

{ #category : 'accessing' }
PRPillarConfiguration class >> headerConfigurations: anObject [
	HeaderConfigurations := anObject
]

{ #category : 'converting' }
PRPillarConfiguration >> asJson [
	| result |
	result := '' writeStream.
	self properties jsonWriteOn: result.
	^ result contents
]

{ #category : 'helper' }
PRPillarConfiguration >> configureLevelDescription: levelNumber [
	^ PRMagritteHeaderLevelDescription new
		accessor: ('level' , levelNumber asString) asSymbol;
		priority: 100;
		label: 'Header level' , levelNumber asString , ' configuration';
		cocoonDocumentation: (self levelDescriptionCocoonDocumentation: levelNumber);
		cocoonDefaultDocumentation: 'All levels are numbered with digits and all parents are visible.';
		default:
				(PRLevelNumberConfiguration new
						numbering: true;
						size: levelNumber;
						level: levelNumber;
						autoAnchor: false;
						configuration: self;
						yourself);
		classes: PRTitleConfiguration allSubclasses;
		level: levelNumber;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionDefaultExporters [
	<magritteDescription>
	^ MAToManyScalarRelationDescription new
		priority: 100;
		accessor: #defaultExporters;
		label: 'List of the default exporters.';
		cocoonDocumentation: 'Collection of exporters to use when none is explicitely specified. You can specify the exporter you want through the ==-\-to\=== command-line argument.';
		classes: {ByteString};
		default: (Array with: 'text');
		cocoonDefaultDocumentation: 'By default only the text exporter is enabled.';
		addCondition: [ :value | value isNotEmpty ];
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionDefaultScriptLanguage [
	<magritteDescription>
	^ PRMagritteScriptLanguageDescription new
		priority: 100;
		accessor: #defaultScriptLanguage;
		label: 'Default language for scripts.';
		cocoonDocumentation:
				'Indicate the language in scripts when none is specified. This language is used for syntax highlighting. The currently supported languages are ', (PRRealScriptLanguage withAllConcreteClasses collect: #standardName) asCommaStringAnd, '.';
		default: PRUnspecifiedScriptLanguage default;
		cocoonDefaultDocumentation: 'An unspecified language';
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionDisabledPhases [
	<magritteDescription>
	^ MAToManyScalarRelationDescription new
		priority: 100;
		accessor: #disabledPhases;
		label: 'List of disabled phases.';
		cocoonDocumentation: 'Collection of phases that Pillar should ignore.' , "(PRTransformersDocumentation on: String new writeStream) contents," '

For exemple, a value of ==["scriptEvaluator", "section", "transform"]== will disable script evaluation (useful when security is important), sectioning (useful when generating HTML 4) and the transform phases (i.e. all the transformers) .';
		classes: {ByteString};
		default: Array new;
		cocoonDefaultDocumentation: 'By default the collection is empty, i.e., all phases are active.';
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionHeadingLevelOffset [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #headingLevelOffset;
		priority: 100;
		label:
				'Offset of Header counter.';
		cocoonDocumentation: 'Indicate how to convert from the level of a Pillar heading to the level of heading in your exported document.
	For example, a ==headingLevelOffset== of 3 converts a 1st level Pillar heading to an ==<h4>== in HTML.';
		beInteger;
		default: 0;
		min: 0 max: 6;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionInputFile [
	<magritteDescription>
	^ MAFileDescription new
		defaultDirectory: self baseDirectory;
		priority: 100;
		accessor: #inputFile;
		label: 'Input file to parse and export.';
		cocoonDocumentation: 'The Pillar file that must be exported. You can also specify an input file at the end of the command-line interface.';
		default: nil;
		kind: AbstractFileReference;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionLevel1 [
	<magritteDescription>
	^ self configureLevelDescription: 1
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionLevel2 [
	<magritteDescription>
	^ self configureLevelDescription: 2
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionLevel3 [
	<magritteDescription>
	^ self configureLevelDescription: 3
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionLevel4 [
	<magritteDescription>
	^ self configureLevelDescription: 4
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionLevel5 [
	<magritteDescription>
	^ self configureLevelDescription: 5
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionMetadata [
	<magritteDescription>
	^  CCMagritteConfigurationDescription new
		accessor: #metadata;
		priority: 100;
		label: 'Metadata for documents';
		cocoonDocumentation:
			'Each document can have metadata like title or authors';
		cocoonDefaultDocumentation: 'A dictionary of default default metadata';
		default: PRPillarConfiguration new;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionNewLine [
	<magritteDescription>
	^ PRMagritteNewLineDescription new
		accessor: #newLine;
		priority: 100;
		label: 'Representation of a new line.';
		cocoonDocumentation:
				'The string that separates lines in the exported document.
	This is often either LF or CR\+LF but any string is possible.';
		default: Smalltalk os lineEnding;
		cocoonDefaultDocumentation: 'Depend on the operating system.';
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionOutputDirectory [
	<magritteDescription>
	^ MADirectoryDescription new
		accessor: #outputDirectory;
		priority: 100;
		label: 'Output Directory where we export.';
		cocoonDocumentation: 'Indicate where Pillar will create generated files.';
		cocoonDefaultDocumentation: 'The value of ==baseDirectory==';
		default: self baseDirectory;
		defaultDirectory: self baseDirectory;
		kind: AbstractFileReference;
		addCondition: [ :fileRef | fileRef isDirectory or: [ fileRef exists not ]];
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionOutputFile [
	<magritteDescription>
	^ PRMagrittePathOrStreamDescription new
		priority: 100;
		accessor: #outputFile;
		label: 'Output File name';
		cocoonDocumentation: 'If ==separateOutputFiles== is ==false==, indicate the name of the output file. This can also be a write stream.';
		cocoonDefaultDocumentation: 'A file named ''output'' with an extension depending on ==outputType==.';
		default: (RelativePath from: 'output');
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionOutputType [
	<magritteDescription>
	^ MAClassDescription new
		accessor: #outputType;
		priority: 100;
		label: 'Output Type.';
		cocoonDocumentation: 'Indicate the kind of output desired. Can be any of ',(PRDocumentWriter withAllConcreteClasses collect: #writerName) asCommaStringAnd,'.';
		default: nil;
		addCondition: [ :value | (PRDocumentWriter allSubclasses reject: [ :klass | klass isAbstract ]) anySatisfy: [ :each | each = value ] ];
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionRenderStructureAsSlide [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #renderStructureAsSlide;
		priority: 100;
		label: 'Render the Structure as Slide for Sliders.';
		cocoonDocumentation:
				'When ==true== (the default), Pillar will create a dedicated slide for each Pillar header. This parameter is meaningless when generating a written document.';
		default: true;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionScrambledEmailAddresses [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #scrambledEmailAddresses;
		priority: 100;
		label: 'Scramble Email Addresses.';
		cocoonDocumentation:
				'Indicate if email addresses should appear scrambled to defeat the stupidest spammers looking for them (the default). If ==false==, email addresses will appear unscrambled.';
		default: true;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionSeparateOutputFiles [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #separateOutputFiles;
		priority: 100;
		label: 'Export with separate output files.';
		cocoonDocumentation: 'If ==true==, each input file is exported to one output file. If ==false== (the default), all input files are exported to ==outputFile==.';
		default: false;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionSlideInTemplateForDeckJS [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #slideInTemplateForDeckJS;
		priority: 100;
		label: 'Number of slides in Template';
		cocoonDocumentation: 'Indicate the number of slides created by the DeckJS template. This is important to create anchors.';
		default: 1;
		isInteger;
		min: -7 max: 7;
		yourself
]

{ #category : 'descriptions' }
PRPillarConfiguration >> descriptionVerbose [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #verbose;
		priority: 100;
		label: 'Verbose log';
		cocoonDocumentation: 'Indicate whether Pillar should write a verbose log when exporting.';
		default: false;
		yourself
]

{ #category : 'accessing' }
PRPillarConfiguration >> disabledPhases [

	^ disabledPhases ifNil:[disabledPhases := OrderedCollection new]
]

{ #category : 'accessing' }
PRPillarConfiguration >> disabledPhases: anObject [

	disabledPhases := anObject
]

{ #category : 'actions' }
PRPillarConfiguration >> export [
	(PRCompilationPipeline buildPipe: self) sort
		executeOn: (PRCompilationContext configuration: self)
]

{ #category : 'actions' }
PRPillarConfiguration >> export: aConfigurationName [
	self log: 'Exporting ' , aConfigurationName.
	(self getConfigurationNamed: aConfigurationName) export.
	self log: 'End of exporting ' , aConfigurationName
]

{ #category : 'configurations' }
PRPillarConfiguration >> findDefaultConfigurationNamed: aString [
	"Search for a default configuration named ==aString== by asking the document writer classes for their default configurations. Raise an exception if no writer class defines a configuration named ==aString==. If a writer class defines such a configuration, merge its properties."
	| writerClass defaultConfiguration newConfiguration |
	writerClass := PRDocumentWriter allSubclasses
		detect: [ :each | each isAbstract not and: [ each defaultConfigurationName = aString ] ]
		ifNone: [ PRConfigurationError signal: 'No default configuration named: ' , aString ].
	defaultConfiguration := writerClass defaultConfiguration.
	newConfiguration := self class new.
	newConfiguration parent: self.
	defaultConfiguration properties
		keysDo:
			[ :propertyName | 
			(newConfiguration inheritsPropertyAt: propertyName)
				ifFalse:
					[ 
					newConfiguration
						propertyAt: propertyName
						put: (defaultConfiguration propertyAt: propertyName) ] ].
	^ newConfiguration
]

{ #category : 'private' }
PRPillarConfiguration >> formatValue: aValue [

	^ aValue isString
			ifTrue:[ '"', aValue, '"' ]
			ifFalse:[ aValue asString ]
]

{ #category : 'configurations' }
PRPillarConfiguration >> getConfigurationNamed: aConfigurationName [
	^ (self subConfigurationNamed: aConfigurationName) ifNil: [ self findDefaultConfigurationNamed: aConfigurationName ]
]

{ #category : 'accessing' }
PRPillarConfiguration >> inputString: aString [
	"I transform aString as a File and I add it to the properties"
	
	| inputFile |
	self baseDirectory: FileSystem memory root.
	inputFile := self baseDirectory / 'input.conf'.
	inputFile writeStreamDo: [ :stream | 
		| znWriteStream |
		znWriteStream := ZnCharacterWriteStream on: stream binary.
		znWriteStream nextPutAll: aString ].
	self inputFile: inputFile.
]

{ #category : 'accessing' }
PRPillarConfiguration >> levelConfigurationFor: aHeader [
	"I return a PRNumberingConfiguration corresponding for a Header."

	^ self perform: ('level' , aHeader level asString) asSymbol
]

{ #category : 'helper' }
PRPillarConfiguration >> levelDescriptionCocoonDocumentation: levelNumber [
	|  level |
	level := levelNumber asString.
	^ 'Configure how headers at level ', level, ' will be rendered. Value must be a dictionnary. These keys are recognized:
;==numbering==
:a boolean indicating if headers at this level must be numbered
;==size==
:a positive number indicating how many parent levels should be visible in the number: e.g., if ==2==, the parent header''s number and the current header''s number will be shown (must be lower than or equal to ', level,')
;==renderAs==
:a string indicating how the numbering is done (must be one of =="number"==, =="roman"==, =="letter"== or =="upperLetter"==)'
]

{ #category : 'converting' }
PRPillarConfiguration >> outputFileName [
	^ self outputFile isStream
		ifFalse: [ self outputFile basename withoutPeriodSuffix ]
		ifTrue: [ 'writeStream' ]
]

{ #category : 'accessing' }
PRPillarConfiguration >> outputStream: aStream [
	self outputFile: aStream
]

{ #category : 'accessing' }
PRPillarConfiguration >> pharoExtensions [
	^ #('image' 'changes')
]

{ #category : 'accessing' }
PRPillarConfiguration >> pharoRelativeNames [
	^ #('pillar' 'pharo' 'stderr' 'stdout' 'stdin' 'package-cache' 'pharo-vm' 'play-cache' 'play-stash')
]
