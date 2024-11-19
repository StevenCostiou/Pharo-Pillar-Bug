"
I am a phase of the export of Pillar files. 

I take in input a colletion of PRDocument, I transform them and I export them.
"
Class {
	#name : 'PRExportPhase',
	#superclass : 'PRPhase',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRExportPhase class >> dependencies [
	^ { PRFileInclusion }
]

{ #category : 'meta-data' }
PRExportPhase class >> pipelineKey [
	^ #compilation
]

{ #category : 'actions' }
PRExportPhase >> actionOn: anInput [
	| writer output |
	"We create the directories before the files to avoir a FileDoesNotExistException."
	self configuration: anInput configuration.
	writer := self instantiateWriter
		configuration: self configuration;
		yourself.
	self configuration outputFile isStream
		ifFalse: [ self configuration
				outputFile: (self configuration outputFile withExtension: writer fileExtension) ].
	output := self write: anInput input using: writer.
	^ output
]

{ #category : 'private' }
PRExportPhase >> asJson: anOutput withConfiguration: aConfig [
	| output config |
	
	output := '' writeStream.
	config := aConfig metadata properties jsonWriteOn: output.
	^ output contents.
]

{ #category : 'actions' }
PRExportPhase >> createSymbolicLink [
	| linkName |
	(self configuration outputFile isStream
		or: [ self configuration outputDirectory
				= self configuration baseDirectory ])
		ifTrue: [ ^ self ].
	linkName := (self configuration outputDirectory
		resolve: self configuration outputFile) parent fullName , '/root'.
	PRCreateSymLink new
		createSymbolic: linkName
		to: self configuration outputDirectory fullName
]

{ #category : 'private' }
PRExportPhase >> extractDataFrom: aDocument using: aWriter [
	| subConfiguration |
	subConfiguration := self configuration class new.
	subConfiguration parent: self configuration.
	CCMagritteDictionaryReader
		writeDictionary: aDocument properties copy
		toConfiguration: subConfiguration.
	self mergeConfiguration: subConfiguration.
	^ subConfiguration
]

{ #category : 'private' }
PRExportPhase >> instantiateWriter [
	^ self configuration outputType new
]

{ #category : 'private' }
PRExportPhase >> mergeConfiguration: aConfig [
	| conf |
	aConfig parent
		ifNil: [ ^ aConfig ].
	conf := self mergeConfiguration: aConfig parent.
	conf metadata properties
		keysDo: [ :each | 
			aConfig metadata
				propertyAt: each
				ifAbsentPut: [ conf metadata propertyAt: each ] ].
	^ aConfig.
]

{ #category : 'actions' }
PRExportPhase >> outputFor: file [
	^ self configuration outputDirectory
		resolve: (file relativeTo: self configuration baseDirectory) 
]

{ #category : 'private' }
PRExportPhase >> outputStreamDuring: aBlock [
	| output |
	output := self configuration outputFile isStream
		ifTrue: [ self configuration outputFile ]
		ifFalse: [ self configuration outputDirectory resolve: self configuration outputFile ].
	output pillarWriteDuring: aBlock.
	self createSymbolicLink.
	^ output
]

{ #category : 'private' }
PRExportPhase >> write: aDocument using: aWriter [
	| output cocoonConfiguration |
	cocoonConfiguration := self extractDataFrom: aDocument using: aWriter.
	output := aWriter write: aDocument.
	cocoonConfiguration metadata propertyAt: 'content' put: output.
	^ self
		outputStreamDuring: [ :outStream | 
			self
				writeOutput: (self asJson: output withConfiguration: cocoonConfiguration)
				toStream: outStream ]
]

{ #category : 'private' }
PRExportPhase >> writeOutput: output toStream: outputStream [
	outputStream nextPutAll: output.
	outputStream flush
]
