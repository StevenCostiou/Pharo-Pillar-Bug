"
I am a phase of the export of Pillar files. 

I take in input a colletion of pillar files, I transform them and I return a collection of PRDocument.
"
Class {
	#name : 'PRParsingPhase',
	#superclass : 'PRPhase',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRParsingPhase class >> dependencies [
	^ {PRCreationPhase}
]

{ #category : 'meta-data' }
PRParsingPhase class >> pipelineKey [
	^ #compilation
]

{ #category : 'action' }
PRParsingPhase >> actionOn: anInput [
	"I take a collection of files, I parse them, I can transform them and I return a collection of PRDocument."
	self configuration: anInput configuration.
	^ self parseInput: anInput input
]

{ #category : 'error' }
PRParsingPhase >> errorNoInputFile [

	PRNoInputFileError signal: 'No input file'
]

{ #category : 'parsing' }
PRParsingPhase >> parse: stdin on: documents [
	| input |
	stdin atEnd
		ifTrue: [ ^ self errorNoInputFile ].
	input := String
		streamContents: [ :s | [ stdin atEnd ] whileFalse: [ stdin next ifNotNil: [ :char | s nextPut: char ] ] ].
	documents add: (PRDocument parser parse: input)
]

{ #category : 'parsing' }
PRParsingPhase >> parseFile: aFile [
	| result subConfiguration |
	result := PRDocument simulateParse: aFile.
	subConfiguration := self configuration class new.
	subConfiguration parent: self configuration. 
	CCMagritteDictionaryReader writeDictionary: result properties copy toConfiguration: subConfiguration.
	self configuration: subConfiguration.
	^ result
]

{ #category : 'parsing' }
PRParsingPhase >> parseInput: aFile [
	^ PRCompilationContext
		withDocument:
			(aFile
				ifNil: [ self halt. self parse: FileStream stdin on: Array new ]
				ifNotNil: [ self parseFile: aFile ])
		withConfiguration: self configuration
]
