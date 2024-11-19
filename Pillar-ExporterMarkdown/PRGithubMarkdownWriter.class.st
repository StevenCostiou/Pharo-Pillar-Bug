"
I am a writer for the GitHub markdown which differs a bit from the `original` markdown.
"
Class {
	#name : 'PRGithubMarkdownWriter',
	#superclass : 'PRMarkdownWriter',
	#instVars : [
		'firstRow'
	],
	#category : 'Pillar-ExporterMarkdown',
	#package : 'Pillar-ExporterMarkdown'
}

{ #category : 'accessing' }
PRGithubMarkdownWriter class >> writerName [
	^ #githubmarkdown
]

{ #category : 'protected' }
PRGithubMarkdownWriter >> scriptLayout: aScript [
	| language |
	language := self languageForScript: aScript.
	canvas nextPutAll: '```'.
	language isSyntaxHighlightingPossible ifTrue: [ canvas raw: language printString ].
	canvas raw: aScript text, '```'
]

{ #category : 'visiting-document' }
PRGithubMarkdownWriter >> visitTable: aTableCell [
	firstRow := true.
	self visitDocumentGroup: aTableCell.
	canvas newLine.
]

{ #category : 'visiting-document' }
PRGithubMarkdownWriter >> visitTableCell: aTableCell [
	canvas raw: aTableCell text
]

{ #category : 'visiting-document' }
PRGithubMarkdownWriter >> visitTableRow: aTableRow [

	stream << '| '.
	self visitAll: aTableRow children separatedBy: [ stream << ' | ' ].
	firstRow ifTrue: [ 
		stream newLine.
		firstRow := false.
		
		aTableRow children do: [ :aTableCell | 
			stream << '| '.	
				aTableCell isAligned 
					ifTrue: [
						aTableCell isAlignedLeft ifTrue: [ stream << ':---' ].
						aTableCell isAlignedCenter ifTrue: [ stream << ':---:' ].
						aTableCell isAlignedRight ifTrue: [ stream << '---:' ] ]
					ifFalse: [ stream << ':---:' ] ] ].
	stream newLine
]

{ #category : 'visiting-document' }
PRGithubMarkdownWriter >> visitUnderlineFormat: aFormat [
	super visitFormat: aFormat 
]
