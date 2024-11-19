"
I generate a documentation about the different script languages from class which inherit from PRRealScriptLanguage.
"
Class {
	#name : 'PRDocGeneratorAboutScriptLanguage',
	#superclass : 'Object',
	#instVars : [
		'stream'
	],
	#category : 'Pillar-Model-ScriptLanguage',
	#package : 'Pillar-Model-ScriptLanguage'
}

{ #category : 'instance creation' }
PRDocGeneratorAboutScriptLanguage class >> on: aStream [ 	
	"I generate the documentation of the scripts languages on a Stream."
	
	^self new 
		stream: aStream;
		generateDoc;
		stream
]

{ #category : 'action' }
PRDocGeneratorAboutScriptLanguage >> generateDoc [
	"I return a Stream with the documentation of the script languages supported by pillar's script."

	PRRealScriptLanguage subclasses do: [ :subClass | self writeDocOf: subClass ].
	^ self stream
]

{ #category : 'initialization' }
PRDocGeneratorAboutScriptLanguage >> initialize [
	super initialize.
	self stream: String new writeStream
]

{ #category : 'accessing' }
PRDocGeneratorAboutScriptLanguage >> stream [
	^ stream
]

{ #category : 'accessing' }
PRDocGeneratorAboutScriptLanguage >> stream: anObject [
	stream := anObject
]

{ #category : 'printing' }
PRDocGeneratorAboutScriptLanguage >> writeDocOf: aClass [
	self writeDocOf: aClass on: self stream
]

{ #category : 'printing' }
PRDocGeneratorAboutScriptLanguage >> writeDocOf: aClass on: aStream [
	aStream
		nextPutAll: '- ';
		nextPutAll: aClass name;
		nextPutAll: ' which tag is: ';
		nextPutAll: aClass standardName; lf
]
