"
I am an abstract class to represent an open-ended syntax for special text.

Description
----------------------------

I allow to extend easily the syntax of Pillar. I am contained inside a PRDocumentGroup. I am define by a tag and I can have some parameters.

Public API and Key Messages
----------------------------

- #tag
    This class method define the tag of an annotation.

- #parameters: aCollection
    This class method is the constructor of an annotation. This method take a dictionary of parameters.

Example 
----------------------------

I am an abstract class, I should not be use directly.

Internal Representation and Key Implementation Points.
----------------------------

    Instance Variables
	hadAllKeys:		I am a boolean. I  know if all the parameters write by the user had a key or if one didn't had a key. To export the document, this is useless except for the Pillar writer.
	parameters:		I  keep all the parameters of the annotation with a key and a value.
			

The name at the begining of each annote is called the tag (e.g., 'index', 'note', 'cite'). The tag is followed by a series of associations (key/value pairs).

Todo
------------------------

- ${todo} to represent a position in the text where things must be changed
- ${note:value=some text}$ (equivalent to previous one) (the default value= works the same as for Java annotations);
- ${index:AClass}$ to add AClass to the document index;
- ${cite:Duca99b}$ to reference a particular item of a bibliography;
- ${cite:value=Duca99b|page=90}$ (equivalent to previous one but additionaly specifies a page number;
- ${background:file://foobar.png}$ to specify the background of the current section;
- ${toc:maxLevel=2}$ to show a table of content with only level 1 and 2 section headings.
- ${note:some text with a curly brace \} inside}$ (shows how to escape a curly brace).
"
Class {
	#name : 'PRAbstractAnnotation',
	#superclass : 'PRDocumentItem',
	#traits : 'PRTParametrizable',
	#classTraits : 'PRTParametrizable classTrait',
	#instVars : [
		'parameters',
		'hadAllKeys'
	],
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'protected' }
PRAbstractAnnotation class >> acceptName: aTag [ 
	^ aTag asSymbol = self tag
]

{ #category : 'protected' }
PRAbstractAnnotation class >> adaptKeysOn: aCollection [
	| newDictionary |
	newDictionary := SmallDictionary new.
	aCollection
		keysDo: [ :key | 
			(aCollection at: key) isNil
				ifTrue: [ newDictionary at: self defaultParameterName put: key ]
				ifFalse: [ newDictionary at: key put: (aCollection at: key) ] ].
	^ newDictionary
]

{ #category : 'protected' }
PRAbstractAnnotation class >> checkKeysOf: aCollection [
	| nilParameters |
	nilParameters := 0.
	aCollection values
		do: [ :each | 
			each isNil
				ifTrue: [ nilParameters := nilParameters + 1 ] ].
	self raiseErrorIfTooManyParameters: nilParameters.
	^ nilParameters = 1
		ifTrue: [ self adaptKeysOn: aCollection ]
		ifFalse: [ aCollection ]
]

{ #category : 'accessing' }
PRAbstractAnnotation class >> defaultParameterName [
	"Each annotation can have some parameters. A parameter have a key and a value. We allow for each annotation to have 1 parameters without key inside the pillar document. I return the key of this parameter."

	^ 'value'
]

{ #category : 'protected' }
PRAbstractAnnotation class >> findClassAcceptingTag: aTag [
	^ self withAllConcreteClasses
		detect: [ :class | class acceptName: aTag ]
		ifNone: [ PRSyntaxError signal: 'Pillar doesn''t support this tag : ''' , aTag , ''' on his annotations.' ]
]

{ #category : 'testing' }
PRAbstractAnnotation class >> isAbstract [
	^ self = PRAbstractAnnotation
]

{ #category : 'accessing' }
PRAbstractAnnotation class >> markupParameterSeparator [
	^ $:
]

{ #category : 'instance creation' }
PRAbstractAnnotation class >> parameters: aCollection [
	| parameters |
	parameters := self checkKeysOf: aCollection.
	^ self new
		hadAllKeys: aCollection = parameters;
		parameters: (PRMagritteDictionaryReader writeDictionary: parameters for: self);
		yourself
]

{ #category : 'protected' }
PRAbstractAnnotation class >> raiseErrorIfTooManyParameters: nilParameters [
	nilParameters > 1
		ifTrue: [ PRError signal: 'More than one parameter have no key in ' , self tag , ' annotation.' ]
]

{ #category : 'protected' }
PRAbstractAnnotation class >> tag [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
PRAbstractAnnotation >> = anObject [
	^ super = anObject and: [ self parameters = anObject parameters and: [ self hadAllKeys = anObject hadAllKeys ] ]
]

{ #category : 'visiting' }
PRAbstractAnnotation >> accept: aVisitor [
	aVisitor visitAnnotation: self
]

{ #category : 'accessing' }
PRAbstractAnnotation >> hadAllKeys [
	^ hadAllKeys ifNil: [ true ]
]

{ #category : 'accessing' }
PRAbstractAnnotation >> hadAllKeys: anObject [
	hadAllKeys := anObject
]

{ #category : 'comparing' }
PRAbstractAnnotation >> hash [
	^ super hash bitXor: self parameters hash
]

{ #category : 'initialization' }
PRAbstractAnnotation >> initialize [
	super initialize.
	parameters := SmallDictionary new
]

{ #category : 'accessing' }
PRAbstractAnnotation >> parameters [
	^ parameters
]

{ #category : 'accessing' }
PRAbstractAnnotation >> parameters: aCollection [
	parameters := aCollection
]

{ #category : 'copying' }
PRAbstractAnnotation >> postCopy [
	super postCopy.
	parameters := parameters copy.
	hadAllKeys := hadAllKeys copy
]
