"
I'm created with an anchorsMapping and i give counters at each internal links of the document I visit.
"
Class {
	#name : 'PRNumeratingLinksVisitor',
	#superclass : 'PRNodeTransformer',
	#instVars : [
		'anchorsMapping'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRNumeratingLinksVisitor class >> dependencies [
	^ {PRNumeratingVisitor}
]

{ #category : 'accessing' }
PRNumeratingLinksVisitor class >> executeOn: anInput [
	self new
		configuration: anInput configuration;
		anchorsMapping: (anInput propertyAt: #anchorsMapping);
		start: anInput input.
	^ anInput
]

{ #category : 'accessing' }
PRNumeratingLinksVisitor class >> key [
	^ #numerator
]

{ #category : 'accessing' }
PRNumeratingLinksVisitor class >> pipelineKey [
	^ #numerating
]

{ #category : 'instance creation' }
PRNumeratingLinksVisitor class >> with: anAnchorsMapping [
	^ self new
		anchorsMapping: anAnchorsMapping;
		yourself
]

{ #category : 'accessing' }
PRNumeratingLinksVisitor >> anchorCounter: aString [
	^ anchorsMapping at: aString ifAbsent: [ self cantFindCounterNamed: aString for: 'anchor' ]
]

{ #category : 'accessing' }
PRNumeratingLinksVisitor >> anchorsMapping: anObject [
	anchorsMapping := anObject
]

{ #category : 'errors' }
PRNumeratingLinksVisitor >> cantFindCounterNamed: counterName for: kind [
	PRReferenceNotFound signal: 'Can''t find ', kind, ' named ''', counterName, ''''.
	^ PRNotFoundCounter new
]

{ #category : 'testing' }
PRNumeratingLinksVisitor >> isEmpty [
	^  anchorsMapping isEmpty 
]

{ #category : 'visiting-document' }
PRNumeratingLinksVisitor >> visitInternalLink: anInternalLink [
	anInternalLink hasAnchor
		ifTrue: [ anInternalLink counter: (self anchorCounter: anInternalLink anchor) ]
]
