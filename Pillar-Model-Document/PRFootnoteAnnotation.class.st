"
I am an annotation that mark a footnote

My tag is 'footnote'
My parameters are :
- note=aString

 
"
Class {
	#name : 'PRFootnoteAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'accessing' }
PRFootnoteAnnotation class >> defaultParameterName [
	^ 'note'
]

{ #category : 'protected' }
PRFootnoteAnnotation class >> tag [
	^ #footnote
]

{ #category : 'as yet unclassified' }
PRFootnoteAnnotation >> accept: aVisitor [
	aVisitor visitFootnoteAnnotation: self
]

{ #category : 'descriptions' }
PRFootnoteAnnotation >> descriptionNote [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #note;
		priority: 100;
		label: 'Content of the note';
		required: true;
		yourself
]
