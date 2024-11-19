"
I am a phase of the export of Pillar files

I take in input, a collection of PRDcument, I check the files, and I return them.
"
Class {
	#name : 'PRCheckPhase',
	#superclass : 'PRVisitor',
	#traits : 'PRTPipe',
	#classTraits : 'PRTPipe classTrait',
	#instVars : [
		'configuration'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'instance-creation' }
PRCheckPhase class >> executeOn: anInput [
	self new
		configuration: anInput configuration;
		start: anInput input.
	^ anInput
]

{ #category : 'testing' }
PRCheckPhase class >> isAbstract [
	^ self = PRCheckPhase 
]

{ #category : 'accessing' }
PRCheckPhase class >> key [
	^ nil
]

{ #category : 'meta-data' }
PRCheckPhase class >> pipelineKey [
	^ #check
]

{ #category : 'accessing' }
PRCheckPhase >> configuration [
	^ configuration
]

{ #category : 'accessing' }
PRCheckPhase >> configuration: anObject [
	configuration := anObject
]
