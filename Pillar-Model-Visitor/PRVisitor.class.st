"
I am an abstract visitor. I provide a default implementation of all visit messages that does not descend automatically into children of the visited graph. Subclasses should override all my messages in appropriate ways to visit the nodes they need.
"
Class {
	#name : 'PRVisitor',
	#superclass : 'PRObject',
	#category : 'Pillar-Model-Visitor',
	#package : 'Pillar-Model-Visitor'
}

{ #category : 'testing' }
PRVisitor class >> isAbstract [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	^ true
]

{ #category : 'visiting' }
PRVisitor >> start: anObject [
	self visit: anObject
]

{ #category : 'visiting' }
PRVisitor >> visit: anObject [
	anObject acceptDecorated: self
]

{ #category : 'visiting' }
PRVisitor >> visitAll: aCollection [
	aCollection do: [ :each | self visit: each ]
]

{ #category : 'visiting' }
PRVisitor >> visitAll: aCollection separatedBy: aBlock [
	aCollection do: [ :each | self visit: each ] separatedBy: aBlock
]

{ #category : 'visiting-document' }
PRVisitor >> visitAnchor: anObject [
	self visitDocumentItem: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitAnnotatedParagraph: aDocument [
	self visitParagraph: aDocument
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitAnnotation: anAnnotation [
	self visitDocumentItem: anAnnotation
]

{ #category : 'visiting-document' }
PRVisitor >> visitBoldFormat: anObject [
	self visitFormat: anObject
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitCitation: aCitation [
	self visitDocumentItem: aCitation
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitCitationAnnotation: aCitation [
	self visitAnnotation: aCitation
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitColumn: aColumn [
	self visitDocumentGroup: aColumn
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitColumnAnnotation: aColumnAnnotation [
	self visitAnnotation: aColumnAnnotation
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitColumns: aColumns [
	self visitDocumentGroup: aColumns
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitColumnsAnnotation: aColumnsAnnotation [
	self visitAnnotation: aColumnsAnnotation
]

{ #category : 'visiting-document' }
PRVisitor >> visitCommentedLine: aCommentedLine [

]

{ #category : 'visiting-document' }
PRVisitor >> visitDataItem: anObject [
	self visitListItem: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitDefinitionList: anObject [
	self visitList: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitDocument: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitDocumentGroup: anObject [
	self visitAll: anObject children
]

{ #category : 'visiting-document' }
PRVisitor >> visitDocumentItem: anObject [
]

{ #category : 'visiting-document' }
PRVisitor >> visitEmptyParagraph: anObject [
	<ignoreForCoverage "This method is ignored for coverage because visiting an empty paragraph is typically very much different from visiting a paragraph.">
	
	self visitParagraph: anObject
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitEndColumnsAnnotation: aEndColumnsAnnotation [
	self visitAnnotation: aEndColumnsAnnotation
]

{ #category : 'visiting-document' }
PRVisitor >> visitExternalLink: anObject [
	self visitLink: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitFigure: anObject [
	self visitReference: anObject
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitFootnote: aFootnote [
	self visitDocumentItem: aFootnote
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitFootnoteAnnotation: aFootnoteAnnotation [
	self visitAnnotation: aFootnoteAnnotation
]

{ #category : 'visiting-document' }
PRVisitor >> visitFormat: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitHeader: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitHorizontalRule: anObject [
	self visitDocumentItem: anObject
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitInputFileAnnotation: anInputFileAnnotation [
	self visitAnnotation: anInputFileAnnotation
]

{ #category : 'visiting-document' }
PRVisitor >> visitInternalLink: anObject [
	self visitLink: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitItalicFormat: anObject [
	self visitFormat: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitLineBreak: anObject [
	<ignoreForCoverage "This method is ignored for coverage because visiting a line break is typically very much different from visiting a standard document item.">
	self visitDocumentItem: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitLink: anObject [
	self visitReference: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitList: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitListItem: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitMailLink: anObject [
	self visitExternalLink: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitMonospaceFormat: anObject [
	self visitFormat: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitOrderedList: anObject [
	self visitList: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitParagraph: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitPreformatted: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitRaw: aRaw [
	self visitText: aRaw
]

{ #category : 'visiting-document' }
PRVisitor >> visitReference: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitScript: aScript [ 
	self visitText: aScript
]

{ #category : 'visiting-document' }
PRVisitor >> visitSection: aSection [
	self visitDocumentGroup: aSection
]

{ #category : 'visiting-document' }
PRVisitor >> visitSlide: aSlide [
	self visitDocumentGroup: aSlide
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitSlideTitleAnnotation: aSlideTitleAnnotation [
	self visitAnnotation: aSlideTitleAnnotation
]

{ #category : 'visiting-document' }
PRVisitor >> visitStrikethroughFormat: anObject [
	self visitFormat: anObject
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitStructure: aStructure [
	self visitDocumentItem: aStructure
]

{ #category : 'visiting-document' }
PRVisitor >> visitSubscriptFormat: anObject [
	self visitFormat: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitSuperscriptFormat: anObject [
	self visitFormat: anObject
]

{ #category : 'visiting-annotations' }
PRVisitor >> visitTOCAnnotation: aTOCAnnotation [
	self visitAnnotation: aTOCAnnotation
]

{ #category : 'visiting-document' }
PRVisitor >> visitTable: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitTableCell: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitTableRow: anObject [
	self visitDocumentGroup: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitTermItem: anObject [
	self visitListItem: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitText: anObject [
	self visitDocumentItem: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitUnderlineFormat: anObject [
	self visitFormat: anObject
]

{ #category : 'visiting-document' }
PRVisitor >> visitUnorderedList: anObject [
	self visitList: anObject
]
