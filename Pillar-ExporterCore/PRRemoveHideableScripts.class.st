"
I visit a document and I hide scripts with ==hideable== parameter at ==true==.
"
Class {
	#name : 'PRRemoveHideableScripts',
	#superclass : 'PRNodeTransformer',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRRemoveHideableScripts class >> key [
	^ #scriptHide
]

{ #category : 'visiting-document' }
PRRemoveHideableScripts >> visitScript: aScript [
	(aScript isHideable)
		ifTrue: [ self replace: #() ]
]
