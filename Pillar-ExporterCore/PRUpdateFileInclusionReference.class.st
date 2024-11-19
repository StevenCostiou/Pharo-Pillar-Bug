"
I update all reference of figures and internal links for file inclusion 
"
Class {
	#name : 'PRUpdateFileInclusionReference',
	#superclass : 'PRVisitor',
	#instVars : [
		'path'
	],
	#category : 'Pillar-ExporterCore-Utilities',
	#package : 'Pillar-ExporterCore',
	#tag : 'Utilities'
}

{ #category : 'visiting' }
PRUpdateFileInclusionReference class >> isAbstract [
	^ false
]

{ #category : 'visiting' }
PRUpdateFileInclusionReference class >> start: aDocument with: aPath [
	^ self new
		path: aPath;
		start: aDocument
]

{ #category : 'as yet unclassified' }
PRUpdateFileInclusionReference >> newReferenceFor: aReference [
	(aReference reference includesSubstring: 'file://')
		ifTrue: [ ^ aReference reference copyReplaceAll: 'file://' with: 'file://', self path , '/' ].
	^ self path , '/' , aReference reference
]

{ #category : 'as yet unclassified' }
PRUpdateFileInclusionReference >> path [
	^ path
]

{ #category : 'as yet unclassified' }
PRUpdateFileInclusionReference >> path: aPath [
	path := aPath
]

{ #category : 'as yet unclassified' }
PRUpdateFileInclusionReference >> start: anObject [
	super start: anObject.
	^ anObject
]

{ #category : 'as yet unclassified' }
PRUpdateFileInclusionReference >> visitFigure: aFigure [
	aFigure reference: (self newReferenceFor: aFigure).
	super visitFigure: aFigure
]

{ #category : 'as yet unclassified' }
PRUpdateFileInclusionReference >> visitInternalLink: anInternalLink [
	anInternalLink hasReference  
		ifTrue: [ anInternalLink reference: (self newReferenceFor: anInternalLink) ].
	super visitInternalLink: anInternalLink
]
