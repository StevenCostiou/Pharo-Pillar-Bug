"
A Markdown canvas that facilitates writing Markdown to a stream. It essentially use to nesting the lists
"
Class {
	#name : 'PRMarkdownCanvas',
	#superclass : 'PRHTMLCanvas',
	#instVars : [
		'lastIsNewLine'
	],
	#category : 'Pillar-ExporterMarkdown',
	#package : 'Pillar-ExporterMarkdown'
}

{ #category : 'initialization' }
PRMarkdownCanvas >> initialize [
	super initialize.
	lastIsNewLine := true
]

{ #category : 'accessing' }
PRMarkdownCanvas >> lastIsNewLine [
	^ lastIsNewLine
]

{ #category : 'writing text' }
PRMarkdownCanvas >> newLine [
	super newLine.
	lastIsNewLine := true
]

{ #category : 'writing text' }
PRMarkdownCanvas >> nextPut: aCharacter [
	super nextPut: aCharacter.
	lastIsNewLine := false
]

{ #category : 'writing text' }
PRMarkdownCanvas >> potentialNewLine [
	lastIsNewLine ifFalse: [ self newLine ]
]

{ #category : 'writing text' }
PRMarkdownCanvas >> raw: aString [
	super raw: aString.
	lastIsNewLine := false
]
