"
I am the check pipeline, I contain all checkers.
"
Class {
	#name : 'PRCheckPipeline',
	#superclass : 'PRPipeline',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRCheckPipeline class >> dependencies [
	^ {PRParsingPhase}
]

{ #category : 'accessing' }
PRCheckPipeline class >> key [
	^ #check
]

{ #category : 'accessing' }
PRCheckPipeline class >> pipelineKey [
	^ #compilation
]
