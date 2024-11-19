"
I replace each ==inputFile== annotation with the content of the referenced file.
"
Class {
	#name : 'PRFileInclusion',
	#superclass : 'PRTransformerWithoutUselessParagraph',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRFileInclusion class >> dependencies [
	^ { PRTransformPipeline }
]

{ #category : 'testing' }
PRFileInclusion class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
PRFileInclusion class >> key [
	^ #fileInclusion
]

{ #category : 'accessing' }
PRFileInclusion class >> pipelineKey [
	^ #compilation
]

{ #category : 'protected' }
PRFileInclusion >> aboutClass [
	<key: 'fileInclusion' documentation:
		'I replace each ==inputFile== annotation with the content of the referenced file.'>
	^ PRInputFileAnnotation 
]

{ #category : 'visiting-document' }
PRFileInclusion >> buildFileInclusionPipeline: aConfiguration [
	| parse check transform fileInclusion |
	parse := PRParsingPhase buildPipe: aConfiguration.
	check := PRCheckPipeline buildPipe: aConfiguration.
	transform := PRTransformPipeline buildPipe: aConfiguration.
	fileInclusion := PRFileInclusion buildPipe: aConfiguration.
	^ (LPPipeline
		pipes:
			{parse.
			check.
			transform.
			fileInclusion}) sort
]

{ #category : 'visiting-document' }
PRFileInclusion >> pathForFile: aFile [
	^ (aFile copyReplaceAll: self configuration baseDirectory fullName with: FileSystem disk delimiter asString) copyReplaceAll: '//' with: ''  
]

{ #category : 'visitor' }
PRFileInclusion >> specificVisitor: anInputFileAnnotation [
	^ self visitInputFileAnnotation: anInputFileAnnotation
]

{ #category : 'visiting-document' }
PRFileInclusion >> visitInputFileAnnotation: anInputFileAnnotation [
	"I load the file and if the file exist I replace the node of the annotation by the content of the file."

	| file pipeline |
	file := anInputFileAnnotation fileWithConfiguration: self configuration.
	file exists
		ifTrue: [ | parsedFile stream |
			stream := file readStream.
			pipeline := self buildFileInclusionPipeline: self configuration.
			parsedFile := PRUpdateFileInclusionReference
				start:
					(pipeline
						executeOn:
							(PRCompilationContext new
								input: file;
								configuration: self configuration)) input
				with: (self pathForFile: file parent fullName).
			self replace: parsedFile children ]
		ifFalse: [ anInputFileAnnotation errorFileNotFound: file ]
]
