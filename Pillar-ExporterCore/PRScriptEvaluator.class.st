"
I replace each script with ==eval=true== with the result of its evaluation.
"
Class {
	#name : 'PRScriptEvaluator',
	#superclass : 'PRNodeTransformer',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRScriptEvaluator class >> key [
	^ #scriptEvaluator
]

{ #category : 'visiting-document' }
PRScriptEvaluator >> visitScript: aScript [
	aScript isEvaluated
		ifTrue: [ self replace: aScript evaluate ]
]
