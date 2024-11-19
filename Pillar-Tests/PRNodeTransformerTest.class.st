"
Abstract class that should be subclassed for all subclasses of PRNodeTransformer.
"
Class {
	#name : 'PRNodeTransformerTest',
	#superclass : 'TestCase',
	#category : 'Pillar-Tests',
	#package : 'Pillar-Tests'
}

{ #category : 'testing' }
PRNodeTransformerTest class >> isAbstract [
	^ self = PRNodeTransformerTest 
]

{ #category : 'private' }
PRNodeTransformerTest >> actualClass [
	^ PRNodeTransformer
]

{ #category : 'helpers' }
PRNodeTransformerTest >> addText: aString to: aDocumentItem [
	^ aDocumentItem
		add: (PRText content: aString);
		yourself
]

{ #category : 'accessing' }
PRNodeTransformerTest >> configuration [
	^ self configurationClass new
]

{ #category : 'accessing' }
PRNodeTransformerTest >> configurationClass [
	^ PRPillarConfiguration
]

{ #category : 'transformation' }
PRNodeTransformerTest >> executePhase: anInput [
	^ self executePhase: anInput with: self configuration
]

{ #category : 'transformation' }
PRNodeTransformerTest >> executePhase: anInput with: aConfig [
	^ (self actualClass
		executeOn:
			(PRCompilationContext withDocument: anInput withConfiguration: aConfig))
		input
]
