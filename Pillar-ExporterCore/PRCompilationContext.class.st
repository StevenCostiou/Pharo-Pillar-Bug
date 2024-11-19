Class {
	#name : 'PRCompilationContext',
	#superclass : 'PRObject',
	#instVars : [
		'context'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'as yet unclassified' }
PRCompilationContext class >> configuration: aConfiguration [
	^ self new configuration: aConfiguration
]

{ #category : 'as yet unclassified' }
PRCompilationContext class >> isAbstract [
	^ false
]

{ #category : 'as yet unclassified' }
PRCompilationContext class >> withDocument: aDocument withConfiguration: aConfiguration [
	^ self new
		input: aDocument;
		configuration: aConfiguration;
		yourself
]

{ #category : 'accessing' }
PRCompilationContext >> configuration [
	^ self propertyAt: #configuration
]

{ #category : 'accessing' }
PRCompilationContext >> configuration: aConfiguration [
	self propertyAt: #configuration put: aConfiguration 
]

{ #category : 'initialization' }
PRCompilationContext >> initialize [
	super initialize.
	context := Dictionary new 
]

{ #category : 'accessing' }
PRCompilationContext >> input [
	^ self propertyAt: #input
]

{ #category : 'accessing' }
PRCompilationContext >> input: anObject [
	self propertyAt: #input put: anObject
]
