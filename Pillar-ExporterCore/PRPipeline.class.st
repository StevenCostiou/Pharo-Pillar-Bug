"
I represent the concept of pipeline. I can contain phases and other pipelines that have the method pipelineKey corresponding to my key.

My main method is #buildPipe: which builds the pipeline.

I can have a pipelineKey which allows me to be included in an other pipeline.
"
Class {
	#name : 'PRPipeline',
	#superclass : 'PRObject',
	#traits : 'PRTPipe',
	#classTraits : 'PRTPipe classTrait',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'private' }
PRPipeline class >> allConcretePipeClasses [ 
	^ PRTPipe users asArray flatCollect: [ :klass | klass withAllConcreteClasses ]
]

{ #category : 'building' }
PRPipeline class >> allDependencies: aConfiguration [
	^ self dependencies
		collect: [ :each | each buildPipe: aConfiguration ]
]

{ #category : 'building' }
PRPipeline class >> allPipeClasses: aConfiguration [
	^ self allConcretePipeClasses
		select:
			[ :each | each pipelineKey = self key and: [ each isEnabled: aConfiguration ] ]
]

{ #category : 'building' }
PRPipeline class >> allPipes: aConfiguration [
	^ (self allPipeClasses: aConfiguration)
		collect: [ :each | each buildPipe: aConfiguration ]
]

{ #category : 'building' }
PRPipeline class >> buildPipe: aConfiguration [
	 ^ (LPPipeline pipes: (self allPipes: aConfiguration))
		addAllDependencies: (self allDependencies: aConfiguration) sort
]

{ #category : 'testing' }
PRPipeline class >> isAbstract [
	^ self = PRPipeline
]
