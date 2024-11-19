"
STON (Smalltalk Object Notation)
"
Class {
	#name : 'PRSTONScriptLanguage',
	#superclass : 'PRRealScriptLanguage',
	#category : 'Pillar-Model-ScriptLanguage',
	#package : 'Pillar-Model-ScriptLanguage'
}

{ #category : 'testing' }
PRSTONScriptLanguage class >> isAbstract [
	^ false
]

{ #category : 'requirement' }
PRSTONScriptLanguage class >> standardName [
	^ 'ston'
]
