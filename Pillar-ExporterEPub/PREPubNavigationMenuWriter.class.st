"
I write a document as a navigation menu for ePub
"
Class {
	#name : 'PREPubNavigationMenuWriter',
	#superclass : 'PREPubMenuWriter',
	#category : 'Pillar-ExporterEPub',
	#package : 'Pillar-ExporterEPub'
}

{ #category : 'accessing' }
PREPubNavigationMenuWriter class >> fileExtension [
	^'nav.xhtml'
]

{ #category : 'accessing' }
PREPubNavigationMenuWriter class >> writerName [
	^#navmenu
]

{ #category : 'visiting-document' }
PREPubNavigationMenuWriter >> visitHeader: aHeader [
	canvas tag
		name: 'li';
		with: [ canvas tag
				name: 'a';
				parameterAt: 'href' put: (self refFor: aHeader);
				with: [ self visitDocumentGroup: aHeader ] ]
]

{ #category : 'visiting-document' }
PREPubNavigationMenuWriter >> visitSection: aSection [
	canvas tag
		name: 'ol';
		with: [ super visitDocumentGroup: aSection ]
]
