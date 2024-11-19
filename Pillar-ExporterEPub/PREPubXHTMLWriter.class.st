"
I write a document as XHTML for ePub
"
Class {
	#name : 'PREPubXHTMLWriter',
	#superclass : 'PRHTMLWriter',
	#category : 'Pillar-ExporterEPub',
	#package : 'Pillar-ExporterEPub'
}

{ #category : 'accessing' }
PREPubXHTMLWriter class >> fileExtension [
	^'xhtml'
]

{ #category : 'accessing' }
PREPubXHTMLWriter class >> writerName [
	^#xhtml
]

{ #category : 'visiting-document' }
PREPubXHTMLWriter >> visitHeader: aHeader [
	canvas tag
		name: 'div';
		parameterAt: 'id' put: aHeader text asValidSelector;
		with: [ super visitHeader: aHeader ].
	canvas newLine
]
