"
I add line numbers to each script with ==lineNumber=true==.
"
Class {
	#name : 'PRScriptLineNumber',
	#superclass : 'PRNodeTransformer',
	#instVars : [
		'stream'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'accessing' }
PRScriptLineNumber class >> key [
	^ #scriptLineNumber
]

{ #category : 'adding' }
PRScriptLineNumber >> add: aString untilNewLineAt: firstOccurence withNumber: number [
	| length |
	length := firstOccurence + self configuration newLine size -1 .
	self add: (aString first: length) withNumber: number.
	^ aString allButFirst: length
]

{ #category : 'adding' }
PRScriptLineNumber >> add: aString withNumber: number [
	stream
		nextPutAll: number asString;
		nextPutAll: String tab;
		nextPutAll: aString
]

{ #category : 'adding' }
PRScriptLineNumber >> addLineNumberTo: aScript [
	"I add a numerotation at each line of a script."

	| text firstOccurence number |
	text := aScript text.
	number := 1.
	stream := String new writeStream.
	firstOccurence := text indexOfSubCollection: self configuration newLine.
	[ firstOccurence = 0 ]
		whileFalse: [ 
			text := self add: text untilNewLineAt: firstOccurence withNumber: number.
			firstOccurence := text indexOfSubCollection: self configuration newLine.
			number := number + 1 ].
	self add: text withNumber: number.
	^ aScript text: stream contents
]

{ #category : 'testing' }
PRScriptLineNumber >> hasLineNumber: aScript [
	^ aScript parameters at: 'lineNumber' ifPresent: [ :lN | lN = 'true' or: [ lN = true ] ] ifAbsent: [ false ]
]

{ #category : 'visiting-document' }
PRScriptLineNumber >> visitScript: aScript [
	(self hasLineNumber: aScript)
		ifTrue: [ self replace: {self addLineNumberTo: aScript} ]
]
