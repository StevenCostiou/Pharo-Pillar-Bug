Class {
	#name : 'PRPillarLanguage',
	#superclass : 'PRRealScriptLanguage',
	#category : 'Pillar-Model-ScriptLanguage',
	#package : 'Pillar-Model-ScriptLanguage'
}

{ #category : 'testing' }
PRPillarLanguage class >> isAbstract [
	^ false
]

{ #category : 'requirement' }
PRPillarLanguage class >> standardName [
	^ 'pillar'
]
