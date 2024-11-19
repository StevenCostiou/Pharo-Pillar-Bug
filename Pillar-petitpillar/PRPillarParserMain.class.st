"
I'm responsible for starting the parsing process of a Pillar document. If possible, I will use a compiled version of PRPillarParser. I will also use the STON reader to read potentital metadata at the begining of the stream.
"
Class {
	#name : 'PRPillarParserMain',
	#superclass : 'Object',
	#classVars : [
		'UseCompiledParser'
	],
	#category : 'Pillar-petitpillar-Pillar-PetitPillar',
	#package : 'Pillar-petitpillar',
	#tag : 'Pillar-PetitPillar'
}

{ #category : 'compiled parser' }
PRPillarParserMain class >> beCompiled [
	UseCompiledParser := true
]

{ #category : 'compiled parser' }
PRPillarParserMain class >> beNonCompiled [
	UseCompiledParser := false
]

{ #category : 'compiled parser' }
PRPillarParserMain class >> compileParser [
	PRPillarParser new compileWithOptions: {#parserName: . self compiledParserName asSymbol}.
	^ Smalltalk classNamed: self compiledParserName
	
]

{ #category : 'compiled parser' }
PRPillarParserMain class >> compiledParser [
	^ (Smalltalk hasClassNamed: self compiledParserName)
		ifTrue: [ Smalltalk classNamed: self compiledParserName ]
		ifFalse: [ self compileParser ]
]

{ #category : 'compiled parser' }
PRPillarParserMain class >> compiledParserName [
	^ 'PRPillarCompiled'
]

{ #category : 'accessing' }
PRPillarParserMain class >> documentParser [

	^ (self useCompiled and: [ Smalltalk hasClassNamed: 'PPCompiledParser' ])
		ifTrue: [ self compiledParser ]
		ifFalse: [ PRPillarParser ] 
]

{ #category : 'parsing' }
PRPillarParserMain class >> parse: aStringOrStream [
	| stream ston doc |
	stream := aStringOrStream readStream.
	stream atEnd
		ifTrue: [ ^ PRDocument new ].
	ston := self parseProperties: stream.
	doc := self parseDocument: stream upToEnd.
	ston
		keysAndValuesDo: [ :key :value | doc propertyAt: key put: value ].
	^ doc
]

{ #category : 'parsing' }
PRPillarParserMain class >> parse: aString startingAt: aSymbol [
	^ self documentParser parse: aString startingAt: aSymbol
]

{ #category : 'parsing' }
PRPillarParserMain class >> parseDocument: stream [
	^ self documentParser parse: stream
]

{ #category : 'parsing' }
PRPillarParserMain class >> parseProperties: stream [
	| ston isSton |
	isSton := stream next = ${ and: [ stream peek ~~ ${ ].
	stream skip: -1.
	ston := isSton
		ifTrue: [ (STON reader on: stream) next ]
		ifFalse: [ Dictionary new ].
	^ ston
]

{ #category : 'compiled parser' }
PRPillarParserMain class >> useCompiled [
	^ UseCompiledParser ifNil: [ self beCompiled. UseCompiledParser ]
]
