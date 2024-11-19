"
I capitalize all headers following the ==level*== configuration parameters.
"
Class {
	#name : 'PRHeaderCapitalizationTransformer',
	#superclass : 'PRNodeTransformer',
	#instVars : [
		'headerCapitalization'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'as yet unclassified' }
PRHeaderCapitalizationTransformer class >> capitalizationConfiguration [

	^ Dictionary with: 'upper case' -> [ :text | text asUppercase ]
					 with: 'lower case' -> [ :text | text asLowercase ]
					 with: 'capitalize' -> [ :text | self new capitalizeHeader: text ]
					 with: 'capitalize english' -> [ :text | self new capitalizeEnglish: text ]
					 with: 'raw' -> [ :text | text ]
]

{ #category : 'accessing' }
PRHeaderCapitalizationTransformer class >> key [
	^ #capitalization
]

{ #category : 'as yet unclassified' }
PRHeaderCapitalizationTransformer class >> nonCapitalizedWordEnglish [

	| result |
	result := Set with: 'to' with: 'and' with: 'or' with: 'an' with: 'a' with: 'of'.
			result addAll: (Set with: 'the' with: 'but' with: 'nor' with: 'for' with: 'yet' with: 'so').
			result addAll: (Set with: 'on' with: 'at' with: 'in').
			
	^ result
]

{ #category : 'visiting-document' }
PRHeaderCapitalizationTransformer >> capitalizeEnglish: aString [

	| substrings result |
	substrings := (aString substrings) asOrderedCollection.
	result := '' writeStream.
	result << (substrings removeFirst) capitalized << ' '.

	substrings do: [ :each | result << ((self class nonCapitalizedWordEnglish includes: each)
																					ifTrue: [ each ]
																					ifFalse: [ each capitalized ])
														  << ' '].
	
	^ result contents trimBoth

]

{ #category : 'visiting-document' }
PRHeaderCapitalizationTransformer >> capitalizeHeader: aString [
	
	| stream |
	stream := '' writeStream.
	((aString substrings) inject: '' into: [ :subtotal :next | stream << next capitalized << ' ' ]).
	^ stream contents trimBoth
]

{ #category : 'visiting-document' }
PRHeaderCapitalizationTransformer >> initialize [
	super initialize.
	headerCapitalization := 'raw'
]

{ #category : 'visiting-document' }
PRHeaderCapitalizationTransformer >> visitHeader: aGroup [

	headerCapitalization := (self configuration levelConfigurationFor: aGroup) capitalization.
	super visitHeader: aGroup.
]

{ #category : 'visiting-document' }
PRHeaderCapitalizationTransformer >> visitText: aText [

	aText text: ((self class capitalizationConfiguration at: headerCapitalization ifAbsent: [[:text|text]]) value: aText text).
	headerCapitalization := 'raw'
]
