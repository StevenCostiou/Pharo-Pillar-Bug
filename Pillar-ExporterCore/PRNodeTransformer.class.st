"
I'm an abstract class. I allows the transformation of a tree. I'll visit a tree and if a node need to be transform i'll replace the node by his transformation.

The replacement is a Stack with all the nodes of the branch of the node I'm visiting.
"
Class {
	#name : 'PRNodeTransformer',
	#superclass : 'PRVisitor',
	#traits : 'PRTPipe',
	#classTraits : 'PRTPipe classTrait',
	#instVars : [
		'replacement',
		'configuration'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'instance-creation' }
PRNodeTransformer class >> executeOn: anInput [
	self new
		configuration: anInput configuration;
		start: anInput input.
	^ anInput
]

{ #category : 'testing' }
PRNodeTransformer class >> isAbstract [
	^ self = PRNodeTransformer 
]

{ #category : 'accessing' }
PRNodeTransformer class >> pipelineKey [
	^ #transform
]

{ #category : 'accessing' }
PRNodeTransformer >> configuration [
	^ configuration
]

{ #category : 'accessing' }
PRNodeTransformer >> configuration: anObject [
	configuration := anObject
]

{ #category : 'accessing' }
PRNodeTransformer >> initialize [
	super initialize.
	replacement := Stack new
]

{ #category : 'protected' }
PRNodeTransformer >> replace: newNodes [
	"When we do a transformation I replace the current node by his transformation."

	replacement pop.
	replacement push: newNodes
]

{ #category : 'visiting' }
PRNodeTransformer >> start: anObject [
	super start: anObject.
	^ anObject
]

{ #category : 'visiting-document' }
PRNodeTransformer >> visitDocumentGroup: aGroup [
	aGroup
		setChildren:
			(aGroup children
				flatCollect: [ :child | 
					replacement push: {child}.
					self visit: child.
					replacement pop]). 
]
