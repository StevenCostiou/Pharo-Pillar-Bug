Class {
	#name : 'LPPipe',
	#superclass : 'Object',
	#instVars : [
		'dependencies',
		'configuration'
	],
	#category : 'LightPhaser-Model',
	#package : 'LightPhaser-Model'
}

{ #category : 'testing' }
LPPipe class >> isAbstract [
	^ self = LPPipe
]

{ #category : 'comparing' }
LPPipe >> <= anObject [
	"a LPPipe is <= than another if the second one depends on it. It means that the second is dependent on the first one."
	^ self allDependencies size <= anObject allDependencies size
]

{ #category : 'adding' }
LPPipe >> addAllDependencies: aPhaseCollection [
	dependencies addAll: aPhaseCollection
]

{ #category : 'adding' }
LPPipe >> addDependency: aPhase [
	dependencies add: aPhase
]

{ #category : 'public' }
LPPipe >> allDependencies [
	| allDependencies |
	allDependencies := self dependencies copy.
	self dependencies do: [ :each | allDependencies addAll: each allDependencies ].
	^ allDependencies
]

{ #category : 'as yet unclassified' }
LPPipe >> configuration: aPRPillarConfiguration [ 
	configuration := aPRPillarConfiguration 
]

{ #category : 'accessing' }
LPPipe >> dependencies [
	^ dependencies
]

{ #category : 'executing' }
LPPipe >> executeOn: anInput [
	self subclassResponsibility
]

{ #category : 'initialization' }
LPPipe >> initialize [
	super initialize.
	dependencies := IdentitySet new
]

{ #category : 'testing' }
LPPipe >> isPipeline [
	^ false
]
