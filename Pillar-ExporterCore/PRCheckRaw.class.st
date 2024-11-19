"
I am a phase of the export of Pillar files

I take in input a collection of PRDocument, I check if the raws have a good type
"
Class {
	#name : 'PRCheckRaw',
	#superclass : 'PRCheckPhase',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'visiting-document' }
PRCheckRaw >> visitRaw: aRaw [
	((PRDocumentWriter withAllConcreteClasses collect: [ :each | each writerName ])
		includes: aRaw type)
		ifTrue: [ ^ self ].
	PRWarning signal: aRaw type , ' is not a valid type for a raw.'.
]
