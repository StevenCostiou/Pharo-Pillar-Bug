"
I am an abstract class to describe a Phase of an export. 
A Phase take an input, transform it and return an output.

configuration is the configuration of the export.

To create a new phase you have to define his prority as a class method then to define the action of the Phase with a method 'actionOn: anInput'. This method will return an output. 
You can also add some transformations to the output like: 

	transformerInputFileOn: aCollection
	<pillarTransformer: 1> ""the parameter is the priority of the transformation""
	aCollection
		do: [ :each | 
			PRFileInclusion new
				configuration: self configuration;
				start: each ]
"
Class {
	#name : 'PRPhase',
	#superclass : 'PRObject',
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
PRPhase class >> executeOn: anInput [
	^ self new
		actionOn: anInput
]

{ #category : 'testing' }
PRPhase class >> isAbstract [
	^ self = PRPhase
]

{ #category : 'accessing' }
PRPhase class >> key [
	^ nil
]

{ #category : 'actions' }
PRPhase >> actionOn: anInput [
	self subclassResponsibility
]

{ #category : 'accessing' }
PRPhase >> configuration [
	^ configuration isNotNil
		ifTrue: [ configuration ]
		ifFalse: [ PRPillarConfiguration new ]
]

{ #category : 'accessing' }
PRPhase >> configuration: aConfiguration [
	configuration := aConfiguration
]
