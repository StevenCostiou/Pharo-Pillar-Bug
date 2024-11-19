"
I'm an abstract class. I allows the transformation of a tree. I'll visit the children of a document a remplace them by a collection of newChildren.

newChildren is a Collection where we stock the new children of PRDocument during the transformation.
"
Class {
	#name : 'PRDocumentChildrenTransformer',
	#superclass : 'PRPhase',
	#instVars : [
		'newChildren'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'testing' }
PRDocumentChildrenTransformer class >> isAbstract [
	^ self = PRDocumentChildrenTransformer 
]

{ #category : 'meta-data' }
PRDocumentChildrenTransformer class >> pipelineKey [
	^ #transform
]

{ #category : 'actions' }
PRDocumentChildrenTransformer >> actionOn: anInput [
	anInput input children
		do: [ :documentItem | self manageItem: documentItem ].
	self possibleTransformationEnding.
	anInput input setChildren: newChildren asArray.
	^ anInput
]

{ #category : 'initialization' }
PRDocumentChildrenTransformer >> initialize [
	super initialize.
	newChildren := OrderedCollection new
]

{ #category : 'private' }
PRDocumentChildrenTransformer >> manageItem: documentItem [
	^ self subclassResponsibility 
]

{ #category : 'private' }
PRDocumentChildrenTransformer >> possibleTransformationEnding [
	"Basicly I do nothing. Override me if you need to do an action before the end of the transformation."

	
]
