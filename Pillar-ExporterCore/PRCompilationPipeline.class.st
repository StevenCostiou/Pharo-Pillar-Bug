"
I am the compilation pipeline, I contain all compilation phases.
"
Class {
	#name : 'PRCompilationPipeline',
	#superclass : 'PRPipeline',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRCompilationPipeline class >> key [
	^ #compilation
]

{ #category : 'accessing' }
PRCompilationPipeline class >> pipelineKey [
	^ nil
]
