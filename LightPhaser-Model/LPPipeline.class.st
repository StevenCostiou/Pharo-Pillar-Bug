"
I am a pipeline of Phases, phases are ordered in dependancy order.
i.e. if a phase had dependencies, those dependencies will be before it in the pipeline.

I can be executed with #executeOn:  which takes an object as input and pass it through all phases in the pipeline.
"
Class {
	#name : 'LPPipeline',
	#superclass : 'LPPipe',
	#instVars : [
		'pipes',
		'pipelineClass'
	],
	#category : 'LightPhaser-Model',
	#package : 'LightPhaser-Model'
}

{ #category : 'initialization' }
LPPipeline class >> pipes: aPipeCollection [
	^ self new pipes: aPipeCollection
]

{ #category : 'comparing' }
LPPipeline >> = aPipeline [
	aPipeline species = self species
		ifFalse: [ ^ false ].
	^ self pipes = aPipeline pipes
]

{ #category : 'executing' }
LPPipeline >> executeOn: anInput [

"	pipes := { pipes first. pipes second. pipes last } asOrderedCollection ."
 	^ pipes inject: anInput into: [ :subResult :next | 
		next isPipeline ifFalse: [ next configuration: subResult configuration ].
		next executeOn: subResult ]
]

{ #category : 'testing' }
LPPipeline >> isPipeline [
	^ true
]

{ #category : 'accessing' }
LPPipeline >> pipelineClass: aClass [

	pipelineClass := aClass
]

{ #category : 'accessing' }
LPPipeline >> pipes [
	^ pipes
]

{ #category : 'accessing' }
LPPipeline >> pipes: aPipeCollection [
	pipes := aPipeCollection
]

{ #category : 'printing' }
LPPipeline >> printOn: aStream [

	aStream
		nextPutAll: self class name asString;
		nextPutAll: '(';
		nextPutAll: pipelineClass name asString;
		nextPutAll: ')'
]

{ #category : 'sorting' }
LPPipeline >> sort [
	pipes := self pipes asSortedCollection asOrderedCollection
		do: [ :each | 
			each isPipeline
				ifTrue: [ each sort ] ]
]
