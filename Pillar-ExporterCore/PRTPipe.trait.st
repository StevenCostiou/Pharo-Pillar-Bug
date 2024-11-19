"
I am a trait used to factorize similar behavior on PRPipeline and PRPhase.
"
Trait {
	#name : 'PRTPipe',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'building' }
PRTPipe classSide >> buildPipe: aConfiguration [
	^ (LPPhase block: [ :input | self executeOn: input ])
		addAllDependencies: (self dependencies collect: [ :each | each buildPipe: aConfiguration ])
]

{ #category : 'meta-data' }
PRTPipe classSide >> dependencies [
	 ^ {  }
]

{ #category : 'instance-creation' }
PRTPipe classSide >> executeOn: anInput [
	^ self explicitRequirement
]

{ #category : 'testing' }
PRTPipe classSide >> isEnabled: aConfiguration [
	^ (aConfiguration disabledPhases includes: self key) not
]

{ #category : 'accessing' }
PRTPipe classSide >> key [
	"A symbol describing what I do."
	^ self explicitRequirement
]

{ #category : 'accessing' }
PRTPipe classSide >> pipelineKey [
	"A symbol representing in which pipeline I should be included. There must be a pipeline which answers my pipelineKey when sending it the message #key."
	^ self explicitRequirement
]
