"
I replace each ==columns== annotation with a structure of columns.
"
Class {
	#name : 'PRColumnsTransformer',
	#superclass : 'PRDocumentChildrenTransformer',
	#instVars : [
		'tmpColumns'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRColumnsTransformer class >> dependencies [
	^ { PRCleanAnnotationInParagraphTransfomer }
]

{ #category : 'accessing' }
PRColumnsTransformer class >> key [
	^ #columns
]

{ #category : 'adding' }
PRColumnsTransformer >> addItem: documentItem [
	self columnsIsInCreation
		ifTrue: [ self currentColumn add: documentItem ]
		ifFalse: [ newChildren add: documentItem ]
]

{ #category : 'testing' }
PRColumnsTransformer >> columnIsInCreation [
	^ self columnsIsInCreation and: [ tmpColumns children isNotEmpty ]
]

{ #category : 'testing' }
PRColumnsTransformer >> columnsIsInCreation [
	^ tmpColumns isNotNil
]

{ #category : 'private' }
PRColumnsTransformer >> createNewColumnWith: aColumnAnnotation [
	self columnsIsInCreation
		ifFalse: [ 
			PRError
				signal:
					'You can''t create a new column if you are not inside a column environment. Please use ${columns}$ before the beginning of a column.' ].
	tmpColumns add: (PRColumn width: (aColumnAnnotation columnAnnotation parameters at: 'width'))
]

{ #category : 'private' }
PRColumnsTransformer >> createNewColumns [
	self columnsIsInCreation
		ifTrue: [ PRError signal: 'You have to close a columns environment before you open an other. Use the ${endColumns}$ tag please.' ]
		ifFalse: [ tmpColumns := PRColumns new ]
]

{ #category : 'accessing' }
PRColumnsTransformer >> currentColumn [
	"If there is no current column begin I return the columns environment and I raise a Warning."

	^ tmpColumns children isNotEmpty
		ifTrue: [ tmpColumns children last ]
		ifFalse: [ tmpColumns ]
]

{ #category : 'private' }
PRColumnsTransformer >> manageItem: documentItem [
	documentItem isColumnsBeginning
		ifTrue: [ self createNewColumns ]
		ifFalse: [ 
			documentItem isColumnBeginning
				ifTrue: [ self createNewColumnWith: documentItem ]
				ifFalse: [ 
					documentItem isColumnsEnding
						ifTrue: [ self pushColumns ]
						ifFalse: [ self addItem: documentItem ] ] ]
]

{ #category : 'private' }
PRColumnsTransformer >> possibleTransformationEnding [
	self columnsIsInCreation
		ifTrue: [ PRError signal: 'Missing ending columns annotation. Please use ${endColumns}$ at the end of the columns environment.' ]
]

{ #category : 'private' }
PRColumnsTransformer >> pushColumns [
	self columnsIsInCreation
		ifTrue: [ 
			newChildren add: tmpColumns.
			tmpColumns := nil ]
		ifFalse: [ PRError signal: 'Column environement ending encounter out of a column environment.' ]
]
