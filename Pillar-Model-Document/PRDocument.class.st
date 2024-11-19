"
I am the root of a document composite.
"
Class {
	#name : 'PRDocument',
	#superclass : 'PRDocumentGroup',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'testing' }
PRDocument class >> isAbstract [
	^ false
]

{ #category : 'as yet unclassified' }
PRDocument class >> parseBar [
	^self readFrom: '(PRDocument basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ((Array new: 2) at: 1 put: (PRParagraph basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ((Array new: 1) at: 1 put: (PRInputFileAnnotation basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ((SmallDictionary new) add: (#value->((RelativePath basicNew: 1)  basicAt: 1 put: ''foo.pillar''; yourself)); yourself); instVarAt: 4 put: false; yourself); yourself); yourself); at: 2 put: (PRHeader basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ((Array new: 1) at: 1 put: (PRText basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ''Bye World''; yourself); yourself); instVarAt: 4 put: 2; yourself); yourself); yourself)' readStream
]

{ #category : 'as yet unclassified' }
PRDocument class >> parseFoo [
	^self readFrom: '(PRDocument basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ((Array new: 1) at: 1 put: (PRHeader basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ((Array new: 1) at: 1 put: (PRText basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (PRNotFoundCounter basicNew instVarAt: 1 put: #(0 0 0 0 0 ); yourself); instVarAt: 3 put: ''Hello World''; yourself); yourself); instVarAt: 4 put: 2; yourself); yourself); yourself)' readStream
]

{ #category : 'as yet unclassified' }
PRDocument class >> simulateParse: path [
 
	path basename = 'bar.pillar' ifTrue: [ ^ self parseBar ].
	^ self parseFoo
]

{ #category : 'visiting' }
PRDocument >> accept: aVisitor [
	aVisitor visitDocument: self
]

{ #category : 'common-properties' }
PRDocument >> authors [
	^ self propertyAt: 'authors' ifAbsent: [ self defaultAuthors ]
]

{ #category : 'common-properties' }
PRDocument >> date [
	^ (self propertyAt: 'date' ifAbsent: [ self defaultDate ]) asDate
]

{ #category : 'common-defaults' }
PRDocument >> defaultAuthors [
	^ ''
]

{ #category : 'common-defaults' }
PRDocument >> defaultDate [
	^ Date today
]

{ #category : 'common-defaults' }
PRDocument >> defaultNext [
	^ nil
]

{ #category : 'common-properties' }
PRDocument >> next [
	^ self propertyAt: 'next' ifAbsent: [ self defaultNext ]
]

{ #category : 'common-properties' }
PRDocument >> next: aDocument [
	^ self propertyAt: 'next' put: aDocument
]
