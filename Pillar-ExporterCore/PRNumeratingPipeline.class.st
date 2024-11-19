"
I am the numerating pipeline, I contain all phases related to numeration. I am included in transform pipeline.
"
Class {
	#name : 'PRNumeratingPipeline',
	#superclass : 'PRPipeline',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRNumeratingPipeline class >> key [
	^ #numerating
]

{ #category : 'accessing' }
PRNumeratingPipeline class >> pipelineKey [
	^ #transform
]
