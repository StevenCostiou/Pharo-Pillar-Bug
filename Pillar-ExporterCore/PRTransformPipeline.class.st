"
I am the transform pipeline, I contain all not disabled transformers.
"
Class {
	#name : 'PRTransformPipeline',
	#superclass : 'PRPipeline',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRTransformPipeline class >> dependencies [
	^ {PRCheckPipeline}
]

{ #category : 'accessing' }
PRTransformPipeline class >> key [
	^ #transform
]

{ #category : 'accessing' }
PRTransformPipeline class >> pipelineKey [
	^ #compilation
]
