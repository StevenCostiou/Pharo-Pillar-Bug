"
I manage LPPhases,  I am responsible for creating a pipeline of phases.
I am responsible for ordering them.
"
Class {
	#name : 'LPPhaser',
	#superclass : 'Object',
	#instVars : [
		'pipes'
	],
	#category : 'LightPhaser-Model',
	#package : 'LightPhaser-Model'
}

{ #category : 'adding' }
LPPhaser >> addPipe: aPipe [
	pipes add: aPipe
]

{ #category : 'building' }
LPPhaser >> buildPipeline [
	| allPhases |
	allPhases := self collectPipe asOrderedCollection.
	^ (LPPipeline pipes: allPhases) sort
]

{ #category : 'enumerating' }
LPPhaser >> collectPipe [
	| pipeCollection |
	pipeCollection := pipes copy.
	pipes do: [ :each | pipeCollection addAll: each allDependencies ].
	^ pipeCollection
]

{ #category : 'initialization' }
LPPhaser >> initialize [
	pipes := IdentitySet new.
	^ super initialize 
]
