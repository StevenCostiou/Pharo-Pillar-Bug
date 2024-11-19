"
I contains the configuration of the numbering of a header level.

My level is the level of the header I describe.

Numbering is a boolean. If numbering is at false the numerator will not take this level of header into account.

If size is at 0 i'll take this level of header into account for the numerator but i'll not render the counter. If my size is at 1 i'll only render the numer of my header level. If my size x i'll render the counter of my level and the counter of x-1 of my parents.

renderAs allow me to know what kind of representation I want for my counter. It can be ""number"", ""roman"", ""letter"" or ""upperLetter"".

If numbering is at false, the size need to be 0.
"
Class {
	#name : 'PRTitleConfiguration',
	#superclass : 'Object',
	#instVars : [
		'numbering',
		'size',
		'level',
		'autoAnchor',
		'configuration',
		'capitalization'
	],
	#category : 'Pillar-ExporterCore-Configuration',
	#package : 'Pillar-ExporterCore-Configuration'
}

{ #category : 'accessing - defaults' }
PRTitleConfiguration class >> defaultLevel [
	^ 1
]

{ #category : 'instance creation' }
PRTitleConfiguration class >> new [
	^ self with: Dictionary new
]

{ #category : 'instance creation' }
PRTitleConfiguration class >> with: aDictionary [
	| config |
	config := super new
		numbering: (aDictionary at: 'numbering' ifAbsent: [ true ]);
		autoAnchor: (aDictionary at: 'autoAnchor' ifAbsent: [ false ]);
		capitalization: (aDictionary at: 'capitalization' ifAbsent: [ 'raw' ]);
		yourself.
	config numbering
		ifTrue: [ config size: (aDictionary at: 'size' ifAbsent: [ 0 ]) ]
		ifFalse: [ config size: 0 ].
	^ config
]

{ #category : 'comparing' }
PRTitleConfiguration >> = anObject [
	^ self species = anObject species
		and: [ self predecessor = anObject predecessor and: [ self numbering = anObject numbering and: [ self size = anObject size ] ] ]
]

{ #category : 'accessing' }
PRTitleConfiguration >> autoAnchor [
	^ autoAnchor 
]

{ #category : 'accessing' }
PRTitleConfiguration >> autoAnchor: anObject [ 
	^ autoAnchor := anObject 
]

{ #category : 'accessing' }
PRTitleConfiguration >> capitalization [
	^ capitalization
]

{ #category : 'accessing' }
PRTitleConfiguration >> capitalization: anObject [
	capitalization := anObject 
]

{ #category : 'accessing' }
PRTitleConfiguration >> configuration [
	^ configuration
]

{ #category : 'accessing' }
PRTitleConfiguration >> configuration: anObject [
	configuration := anObject
]

{ #category : 'rendering' }
PRTitleConfiguration >> elementSeparator [
	^ $.
]

{ #category : 'comparing' }
PRTitleConfiguration >> hash [
	^ self species hash bitXor: (self predecessor hash bitXor: numbering hash)
]

{ #category : 'accessing' }
PRTitleConfiguration >> level [
	^ level ifNil: [ self class defaultLevel ]
]

{ #category : 'accessing' }
PRTitleConfiguration >> level: anObject [
	level := anObject
]

{ #category : 'accessing' }
PRTitleConfiguration >> numbering [
	^ numbering
]

{ #category : 'accessing' }
PRTitleConfiguration >> numbering: anObject [
	numbering := anObject
]

{ #category : 'accessing' }
PRTitleConfiguration >> predecessor [
	^ self level = 1
		ifTrue: [ nil ]
		ifFalse: [ self configuration perform: ('level' , (self level - 1) asString) asSymbol ]
]

{ #category : 'rendering' }
PRTitleConfiguration >> printCounter: aCollection [
	^ self printCounter: aCollection withMaxSize: self size
]

{ #category : 'rendering' }
PRTitleConfiguration >> printCounter: aCollection withMaxSize: aSize [
	| stream |
	stream := String new writeStream.
	aSize > 0
		ifTrue: [ 
			(self predecessor isNotNil and: [ aSize - 1 > 0 ])
				ifTrue: [ 
					stream nextPutAll: (self predecessor printCounter: aCollection allButLast withMaxSize: aSize - 1).
					aCollection allButLast last = -1
						ifFalse: [ stream nextPut: self elementSeparator ] ].
			stream nextPutAll: (self printElement: aCollection last) ].
	^ stream contents
]

{ #category : 'rendering-element' }
PRTitleConfiguration >> printElement: aNumber [
	^ aNumber = -1
		ifTrue: [ '' ]
		ifFalse: [ self renderElement: aNumber ]
]

{ #category : 'rendering-element' }
PRTitleConfiguration >> renderElement: aNumber [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
PRTitleConfiguration >> size [
	^ size
]

{ #category : 'accessing' }
PRTitleConfiguration >> size: anObject [
	size := anObject
]
