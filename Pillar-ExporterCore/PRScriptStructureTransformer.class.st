"
I transform a script structure with the associated structure.
"
Class {
	#name : 'PRScriptStructureTransformer',
	#superclass : 'PRNodeTransformer',
	#instVars : [
		'structure'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRScriptStructureTransformer class >> key [
	^ #structures
]

{ #category : 'creating' }
PRScriptStructureTransformer >> createStructureFrom: aScript [
	^ PRStructure new
		tag: aScript structureName;
		structDict: (Json readFrom: aScript text readStream) asDictionary;
		yourself
]

{ #category : 'visiting-document' }
PRScriptStructureTransformer >> visitScript: aScript [
	aScript isStructure
		ifTrue: [ self replace: (OrderedCollection with: (self createStructureFrom: aScript)) ]
]
