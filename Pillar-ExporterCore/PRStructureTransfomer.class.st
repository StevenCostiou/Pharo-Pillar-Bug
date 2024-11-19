"
I represent the transformation of a structure.
I have a different render for each subclasses.
I can be referenced by a structure which wants to be transformed following my rule.
"
Class {
	#name : 'PRStructureTransfomer',
	#superclass : 'PRNodeTransformer',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRStructureTransfomer class >> key [
	^ #structures
]

{ #category : 'visiting-annotations' }
PRStructureTransfomer >> transformClassFor: aStructureTag [

	^ self transformDictionary at: aStructureTag
]

{ #category : 'visiting-annotations' }
PRStructureTransfomer >> transformDictionary [
	^ Dictionary
		with: 'exercise' -> PRDefinitionListRenderer
		with: 'city' -> PRTableRenderer
		with: 'country' -> PRTableRenderer
		with: 'default' -> PRTableRenderer
]

{ #category : 'visiting-annotations' }
PRStructureTransfomer >> visitStructure: aStructure [
	| transformClass |
	transformClass := (self transformClassFor: aStructure tag) new.
	self replace: (OrderedCollection with: (transformClass  renderFor: aStructure))
]
