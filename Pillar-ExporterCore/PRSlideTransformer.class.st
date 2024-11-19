"
I replace each slide annotation with a slide structure.
"
Class {
	#name : 'PRSlideTransformer',
	#superclass : 'PRDocumentChildrenTransformer',
	#instVars : [
		'tmpSlide'
	],
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'meta-data' }
PRSlideTransformer class >> dependencies [
	^ { PRCleanAnnotationInParagraphTransfomer . PRColumnsTransformer }
]

{ #category : 'accessing' }
PRSlideTransformer class >> key [
	^ #slide
]

{ #category : 'testing' }
PRSlideTransformer >> aSlideIsOpen [
	^ tmpSlide isNotNil
]

{ #category : 'private' }
PRSlideTransformer >> createNewSlideWith: documentItem [
	| slideAnnotation |
	slideAnnotation := documentItem slideAnnotation.	"We do that because our slideAnnotation could be inside a paragraph."
	tmpSlide := (PRSlide titled: (slideAnnotation parameters at: 'title' ifAbsent: [ 'New Slide' ]))
		label: (slideAnnotation parameters at: 'label' ifAbsent: [ nil ])
]

{ #category : 'private' }
PRSlideTransformer >> manageItem: documentItem [
	^ documentItem isSlideBeginning
		ifTrue: [ self pushSlideIfNeeded. self createNewSlideWith: documentItem ]
		ifFalse: [ 
			self aSlideIsOpen
				ifTrue: [ self manageSlideWith: documentItem ]
				ifFalse: [ newChildren add: documentItem ] ]
]

{ #category : 'private' }
PRSlideTransformer >> manageSlideWith: documentItem [
	documentItem isHeader
		ifTrue: [ 
			self pushSlideIfNeeded.
			newChildren add: documentItem ]
		ifFalse: [ tmpSlide add: documentItem ]
]

{ #category : 'private' }
PRSlideTransformer >> possibleTransformationEnding [
	self pushSlideIfNeeded
]

{ #category : 'private' }
PRSlideTransformer >> pushSlideIfNeeded [
	self aSlideIsOpen
		ifTrue: [ 
			newChildren add: tmpSlide.
			tmpSlide := nil ]
]
