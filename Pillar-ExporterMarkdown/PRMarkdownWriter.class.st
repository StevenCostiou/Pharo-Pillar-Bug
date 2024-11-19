"
I am a visitor generating markdown documents
"
Class {
	#name : 'PRMarkdownWriter',
	#superclass : 'PRHTMLWriter',
	#instVars : [
		'nesting'
	],
	#category : 'Pillar-ExporterMarkdown',
	#package : 'Pillar-ExporterMarkdown'
}

{ #category : 'accessing' }
PRMarkdownWriter class >> fileExtension [
	^ 'md'
]

{ #category : 'accessing' }
PRMarkdownWriter class >> writerName [
	^ #markdown
]

{ #category : 'accessing' }
PRMarkdownWriter >> canvasClass [
	^ PRMarkdownCanvas
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> nest: aString do: aBlock [
	nesting add: aString.
	aBlock ensure: [ nesting removeLast ]
]

{ #category : 'protected' }
PRMarkdownWriter >> scriptLayout: aScript [
	| text lines |
	text := aScript text.
	lines := (text substrings: self configuration newLine)
		collect: [ :each | '    ' , each , self configuration newLine ].
	canvas raw: lines.
]

{ #category : 'visiting' }
PRMarkdownWriter >> start: anObject [
	nesting := OrderedCollection new.
	super start: anObject
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitBoldFormat: aFormat [
	canvas raw: '**', aFormat text, '**'
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitExternalLink: anExternalLink [
	self writeExternalLink: anExternalLink.
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitFigure: aFigure [
	canvas raw: '!['.
	aFigure hasLabel ifTrue: [ canvas raw: aFigure label ].
	canvas raw: '](', aFigure localFileOrExternalReference.
	aFigure hasCaption ifTrue: [ canvas raw: ' "', aFigure text, '"' ].
	canvas raw: ')'.
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitHeader: aHeader [
	| level |
	level := aHeader level min: 7 max: 1.
	1 to: level do: [ :each | canvas nextPut: $# ].
	self writeCounterForHeader: aHeader.
	canvas raw: aHeader text.
	canvas newLine
	
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitHorizontalRule: anHorizontalRule [
	canvas newLine; newLine.
	canvas raw: '***'.
	canvas newLine.
	
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitInternalLink: anInternalLink [
	| href |
	href := String new.
	self configuration separateOutputFiles
		ifTrue: [ anInternalLink hasReference
				ifTrue: [ href := href , anInternalLink referenceAsHTML ] ]
		ifFalse: [ self internalLinkWillBeRender: anInternalLink ].
	anInternalLink hasAnchor
		ifTrue: [ href := self addAnchorFrom: anInternalLink To: href ].
	self writeInternalLink: anInternalLink withRef: href.
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitItalicFormat: aFormat [
	canvas raw: '*', aFormat text, '*'
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitListItem: aListItem [
	nesting last isInteger ifTrue: [ nesting addLast: nesting removeLast + 1 ].
	nesting size - 1 timesRepeat: [ canvas raw: '  ' ].
	canvas nextPutAll: nesting last greaseString.
	canvas nextPutAll: (nesting last isInteger 
			ifTrue: [ '. ' ]
			ifFalse: [ ' ' ]).
	self visitDocumentGroup: aListItem.
	canvas potentialNewLine
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitMonospaceFormat: aFormat [
	canvas raw: '`', aFormat text, '`'
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitOrderedList: aList [
	canvas potentialNewLine.
	self nest: '1.' do: [ self visitDocumentGroup: aList ]
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitParagraph: aParagraph [
	self visitDocumentGroup: aParagraph.
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitScript: aScript [
	aScript hasLabel
		ifTrue: [ self createAnchorWith: aScript label.
			canvas newLine ].
	self scriptLayout: aScript.
	aScript hasCaption
		ifTrue: [ canvas
				raw: '**' , aScript caption text , '**';
				newLine ]
]

{ #category : 'visiting-document' }
PRMarkdownWriter >> visitUnorderedList: aList [
	canvas potentialNewLine.
	self nest: '-' do: [ self visitDocumentGroup: aList ]
]

{ #category : 'private' }
PRMarkdownWriter >> writeExternalLink: aExternalLink [
	canvas raw: '[', aExternalLink alias, '](', aExternalLink localFileOrExternalReference, ')'
]

{ #category : 'private' }
PRMarkdownWriter >> writeInternalLink: anInternalLink withRef: href [
	canvas nextPut: $[.
	anInternalLink counter isValidCounter
		ifTrue: [ self writeCounter: anInternalLink counter.
			anInternalLink hasAlias
				ifTrue: [ canvas nextPutAll: ' ' ] ].
	anInternalLink hasAlias
		ifTrue: [ canvas nextPutAll: anInternalLink alias ].
	canvas nextPut: $].
	canvas raw: '(' , href , ')'
]
