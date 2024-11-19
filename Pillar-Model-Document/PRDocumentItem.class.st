"
I am an abstract superclass for the document hierarchy. My subclasses include all the basic elements to represent a document.

Description
----------------------------

Most of the time I will be use by a visitor that will visit me. Each of my subclasses can have his own visitor.
I usually am contain inside a PRDocumentGroup at the exception of PRDocument.

Public API and Key Messages
----------------------------

- #parser
    This class method return the default parser for this document model.

Example
----------------------------

I am an abstract class. I should not be use directly.

Internal Representation and Key Implementation Points.
----------------------------

    Instance Variables
	counter:		I am a counter use by some document items. Maybe I can be improve because not all items need a counter.

"
Class {
	#name : 'PRDocumentItem',
	#superclass : 'PRObject',
	#instVars : [
		'counter'
	],
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'comparing' }
PRDocumentItem >> = anObject [
	^ self species = anObject species
]

{ #category : 'visiting' }
PRDocumentItem >> accept: aVisitor [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	aVisitor visitDocumentItem: self
]

{ #category : 'accessing' }
PRDocumentItem >> counter [
	^ counter
]

{ #category : 'accessing' }
PRDocumentItem >> counter: anObject [
	counter := anObject
]

{ #category : 'testing' }
PRDocumentItem >> hasChildren [
	^ false
]

{ #category : 'comparing' }
PRDocumentItem >> hash [
	^ self species hash
]

{ #category : 'initialization' }
PRDocumentItem >> initialize [
	counter := PRNotFoundCounter maxLevel: 5
]

{ #category : 'testing' }
PRDocumentItem >> isColumnBeginning [
	^ false
]

{ #category : 'testing' }
PRDocumentItem >> isColumnsBeginning [
	^ false
]

{ #category : 'testing' }
PRDocumentItem >> isColumnsEnding [
	^ false
]

{ #category : 'testing' }
PRDocumentItem >> isDocument [
	^self class = PRDocument
]

{ #category : 'testing' }
PRDocumentItem >> isGroup [
	^false
]

{ #category : 'testing' }
PRDocumentItem >> isHeader [
	^ false
]

{ #category : 'testing' }
PRDocumentItem >> isLink [
	^ false
]

{ #category : 'testing' }
PRDocumentItem >> isSlideBeginning [
	^ false
]

{ #category : 'helpers' }
PRDocumentItem >> parser [
  ^ self class parser
]

{ #category : 'accessing-dynamic' }
PRDocumentItem >> text [
	"Answer a string representation of the receiver."

	^ String new
]
