"
An embedded script
"
Class {
	#name : 'PRScript',
	#superclass : 'PRText',
	#traits : 'PRTParametrizable',
	#classTraits : 'PRTParametrizable classTrait',
	#instVars : [
		'parameters',
		'caption'
	],
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'instance creation' }
PRScript class >> content: aString parameters: parameters [
	^ (self content: aString)
		parameters: parameters;
		yourself
]

{ #category : 'comparing' }
PRScript >> = anObject [
	"We use the method language to be sure that the language is a PRAbstractScriptLanguage and not a string."
	
	^ super = anObject
		and: [ 
			self language.
			anObject language.
			self parameters = anObject parameters ]
]

{ #category : 'visiting' }
PRScript >> accept: aVisitor [
	aVisitor visitScript: self
]

{ #category : 'accessing-delegated' }
PRScript >> caption [
	^ caption
		ifNil: [ 
			caption := self
				parameters at: 'caption'
				ifPresent: [ :string | (PRDocument parser parse: string) children first ]
				ifAbsent: [ PRParagraph with: (PRText content: '') ] ]
]

{ #category : 'accessing-delegated' }
PRScript >> caption: aString [
	parameters := self parameters copyWith: 'caption' -> aString
]

{ #category : 'accessing-delegated' }
PRScript >> eval: aString [
	parameters := parameters copyWith: 'eval' -> aString
]

{ #category : 'as yet unclassified' }
PRScript >> evaluate [
	| content |
	content := self evaluationString.
	^ [ (PRDocument parser parse: content) children ]
		on: Error
		do: [ :e | PRBoldFormat with: (PRText content: e messageText) ]
]

{ #category : 'comparing' }
PRScript >> evaluationString [
	^ String
		streamContents: [ :stream | 
			| evaluator |
			evaluator := PRScriptEvaluationEnvironment new
				setStream: stream;
				yourself.
			[ Compiler evaluate: self text for: evaluator logged: false ]
				on: Error
				do: [ :e | 
					stream
						nextPutAll: '= ';
						nextPutAll: e description ] ]
]

{ #category : 'as yet unclassified' }
PRScript >> firstLine: aString [
	parameters := parameters copyWith: 'firstLine' -> aString
]

{ #category : 'as yet unclassified' }
PRScript >> fromFile: aString [
	parameters := parameters copyWith: 'fromFile' -> aString
]

{ #category : 'testing' }
PRScript >> hasCaption [
	^ self parameters at: 'caption' ifPresent: [ :param | param isEmptyOrNil not ] ifAbsent: [ false ]
]

{ #category : 'testing' }
PRScript >> hasLabel [
	| label |
	label := self parameters at: 'label' ifAbsent: [ ^ false ].
	^ label isEmptyOrNil not
]

{ #category : 'testing' }
PRScript >> hasNoCode [
	^ (self text copyWithout: Character tab) isEmpty
]

{ #category : 'testing' }
PRScript >> hasShortCaption [
	^ self parameters at: 'shortCaption'
		ifPresent: [ :param | param isEmptyOrNil not ]
		ifAbsent: [ false ]
]

{ #category : 'comparing' }
PRScript >> hash [
	^ super hash bitXor: self properties hash
]

{ #category : 'accessing-delegated' }
PRScript >> hideable: aString [
	parameters := parameters copyWith: 'hideable' -> aString
]

{ #category : 'initialization' }
PRScript >> initialize [
	super initialize.
	parameters := SmallDictionary new
]

{ #category : 'testing' }
PRScript >> isEvaluated [
	^ self parameters at: 'eval' ifPresent: [ :eva | eva = 'true' or: [ eva = true ] ] ifAbsent: [ false ]
]

{ #category : 'testing' }
PRScript >> isHideable [
	^ self parameters at: 'hideable' ifPresent: [ :hideable | hideable = 'true' or: [ hideable = true ] ] ifAbsent: [ false ]
]

{ #category : 'testing' }
PRScript >> isStructure [
	^ self parameters includesKey: 'structure'
]

{ #category : 'accessing-delegated' }
PRScript >> label [
	^ self parameters at: 'label' ifAbsent: ['']
]

{ #category : 'accessing-delegated' }
PRScript >> label: aString [
	parameters := parameters copyWith: 'label' -> aString
]

{ #category : 'accessing-delegated' }
PRScript >> language [
	^ self
		parameters at: 'language'
		ifPresent: [ :language | 
			language isString
				ifTrue: [ 
					| realObject |
					realObject := PRAbstractScriptLanguage for: language.
					self language: realObject.
					realObject ]
				ifFalse: [ language ] ]
		ifAbsent: [ PRUnspecifiedScriptLanguage default ]
]

{ #category : 'accessing-delegated' }
PRScript >> language: aLanguage [
	self parameters at: 'language' put: aLanguage
]

{ #category : 'as yet unclassified' }
PRScript >> lastLine: aString [
	parameters := parameters copyWith: 'lastLine' -> aString
]

{ #category : 'as yet unclassified' }
PRScript >> lineNumber: aString [
	parameters := parameters copyWith: 'lineNumber' -> aString
]

{ #category : 'accessing-parameters' }
PRScript >> parameters [
	^ parameters
]

{ #category : 'accessing-parameters' }
PRScript >> parameters: aCollection [
	parameters := aCollection
]

{ #category : 'as yet unclassified' }
PRScript >> removePossibleParagraph: content [
	^ (content first class = PRParagraph ) ifTrue:[ content first children ] ifFalse: [ content ]
]

{ #category : 'accessing-delegated' }
PRScript >> shortCaption [
	^ self parameters at: 'shortCaption' ifAbsent: ['']
]

{ #category : 'accessing-delegated' }
PRScript >> shortCaption: aString [ 
	parameters := parameters copyWith: 'shortCaption' -> aString
]

{ #category : 'testing' }
PRScript >> structureName [
	^ self parameters at: 'structure'
]

{ #category : 'testing' }
PRScript >> structureName: aName [
	^ self parameters at: 'structure' put: aName
]

{ #category : 'accessing' }
PRScript >> text: aString [
	super text: aString withoutTrailingNewlines
]
