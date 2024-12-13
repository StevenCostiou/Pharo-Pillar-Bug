"
I am an abstract  writer for menus for ePub
"
Class {
	#name : 'PREPubMenuWriter',
	#superclass : 'PRHTMLWriter',
	#instVars : [
		'maxHeader'
	],
	#category : 'Pillar-ExporterEPub',
	#package : 'Pillar-ExporterEPub'
}

{ #category : 'accessing' }
PREPubMenuWriter class >> fileExtension [
	^self subclassResponsibility 
]

{ #category : 'testing' }
PREPubMenuWriter class >> isAbstract [
	^ self = PREPubMenuWriter 
]

{ #category : 'accessing' }
PREPubMenuWriter class >> writerName [
	^ self subclassResponsibility 
]

{ #category : 'private' }
PREPubMenuWriter >> refFor: aHeader [
	^ 'chapter.xhtml#',aHeader text asValidSelector 
]
