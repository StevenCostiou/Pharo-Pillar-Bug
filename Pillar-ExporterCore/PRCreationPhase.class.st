"
I am a phase of the export of Pillar files. 

I take nothing, I can use a transformer to add files and I return a collection of pillar files.
"
Class {
	#name : 'PRCreationPhase',
	#superclass : 'PRPhase',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRCreationPhase class >> pipelineKey [
	^ #compilation
]

{ #category : 'actions' }
PRCreationPhase >> actionOn: anInput [
	^ PRCompilationContext withDocument: anInput configuration inputFile withConfiguration: anInput configuration
]
