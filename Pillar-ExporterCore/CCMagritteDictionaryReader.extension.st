Extension { #name : 'CCMagritteDictionaryReader' }

{ #category : '*Pillar-ExporterCore' }
CCMagritteDictionaryReader >> buildConfiguration: confName with: confValues [
	| outputType |
	outputType := confValues at: 'outputType' ifAbsent: nil.
	configuration class
		allSubclassesDo: [ :e | 
			e isAbstract
				ifFalse: [ 
					(e configurationName = confName or: [ e configurationName = outputType ])
						ifTrue: [ | subconfiguration |
							subconfiguration := e new.
							subconfiguration parent: configuration.
							CCMagritteDictionaryReader writeDictionary: confValues toConfiguration: subconfiguration.
							^ subconfiguration ] ] ].
	^ self createConfigurationFrom: confValues
]

{ #category : '*Pillar-ExporterCore' }
CCMagritteDictionaryReader >> configuration: aConfiguration [
	"This method is here to do some tests."

	configuration := aConfiguration
]

{ #category : '*Pillar-ExporterCore' }
CCMagritteDictionaryReader >> visitClassDescription: aClassDescription [
	self
		tryToAddFrom: aClassDescription
		withInterpretation: [ :value | PRDocumentWriter allSubclasses detect: [ :klass | klass isAbstract not and: [ klass writerName asString = value ] ] ]
]

{ #category : '*Pillar-ExporterCore' }
CCMagritteDictionaryReader >> visitHeaderLevelDescription: aHeaderLevelDescription [
	self
		tryToAddFrom: aHeaderLevelDescription
		withInterpretation: [ :value | 
			| return |
			return := (configuration class headerConfigurations at: (value at: 'renderAs' ifAbsent: [ 'roman' ])) with: value.
			return
				level: aHeaderLevelDescription level;
				configuration: configuration.
			return ]
]

{ #category : '*Pillar-ExporterCore' }
CCMagritteDictionaryReader >> visitNewLineDescription: aNewLineDescription [
	self
		tryToAddFrom: aNewLineDescription
		withInterpretation: [ :value | 
			value isSymbol
				ifTrue: [ 
					(Dictionary
						newFrom:
							{#cr -> String cr.
							#lf -> UnixPlatform new lineEnding.
							#crlf -> Win32Platform new lineEnding.
							#unix -> UnixPlatform new lineEnding.
							#mac -> UnixPlatform new lineEnding.
							#dos -> Win32Platform new lineEnding}) at: value ]
				ifFalse: [ value ] ]
]

{ #category : '*Pillar-ExporterCore' }
CCMagritteDictionaryReader >> visitPathOrStreamDescription: aPathOrStreamDescription [
	self
		tryToAddFrom: aPathOrStreamDescription
		withInterpretation: [ :path | RelativePath from: path ]
]

{ #category : '*Pillar-ExporterCore' }
CCMagritteDictionaryReader >> visitScriptLanguageDescription: aScriptLanguageDescription [
	self tryToAddFrom: aScriptLanguageDescription withInterpretation: [ :value | PRAbstractScriptLanguage for: value ]
]
