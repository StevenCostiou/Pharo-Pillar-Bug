"
I represent a programming language that can be referenced from a PRScript to get syntax highlighting.
"
Class {
	#name : 'PRAbstractScriptLanguage',
	#superclass : 'PRObject',
	#instVars : [
		'originalName'
	],
	#category : 'Pillar-Model-ScriptLanguage',
	#package : 'Pillar-Model-ScriptLanguage'
}

{ #category : 'protected' }
PRAbstractScriptLanguage class >> acceptLanguage: aLanguageName [
	^ aLanguageName matchesRegexIgnoringCase: self acceptedLanguagesRegex 
]

{ #category : 'requirement' }
PRAbstractScriptLanguage class >> acceptedLanguagesRegex [ 
	^ self standardName
]

{ #category : 'private' }
PRAbstractScriptLanguage class >> concreteClassFor: aLanguageName [
	aLanguageName isNil ifTrue: [ ^ PRUnspecifiedScriptLanguage ].
	^ (self withAllConcreteClasses copyWithout: PRUnsupportedScriptLanguage)
		detect: [ :cl | cl acceptLanguage: aLanguageName ]
		ifNone: [ PRUnsupportedScriptLanguage ]
]

{ #category : 'instance creation' }
PRAbstractScriptLanguage class >> default [
	^ self new
		originalName: self standardName;
		yourself
]

{ #category : 'instance creation' }
PRAbstractScriptLanguage class >> for: aLanguageName [
	^ (self concreteClassFor: aLanguageName) new
		originalName: aLanguageName;
		yourself
]

{ #category : 'protected' }
PRAbstractScriptLanguage class >> standardName [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
PRAbstractScriptLanguage >> = anObject [
	^ self originalName = anObject originalName
]

{ #category : 'comparing' }
PRAbstractScriptLanguage >> hash [
	^ self originalName hash
]

{ #category : 'testing' }
PRAbstractScriptLanguage >> isSpecified [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
PRAbstractScriptLanguage >> originalName [
	^ originalName
]

{ #category : 'accessing' }
PRAbstractScriptLanguage >> originalName: aLanguageName [
	originalName := aLanguageName
]

{ #category : 'printing' }
PRAbstractScriptLanguage >> printOn: aStream [
	aStream nextPutAll: self originalName
]
