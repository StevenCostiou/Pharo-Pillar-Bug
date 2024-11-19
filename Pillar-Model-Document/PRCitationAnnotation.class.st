"
I am an annotation that mark a citation.

My tag is: 'cite'.

I can have in parameter:
- a ref with the key ""ref="" (required, you can write it without the key, take a reference in the LaTeX bib format)


Examples: 

${cite:foo}$

${cite:ref=foo}$
"
Class {
	#name : 'PRCitationAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'as yet unclassified' }
PRCitationAnnotation class >> defaultParameterName [
	^'ref'
]

{ #category : 'as yet unclassified' }
PRCitationAnnotation class >> tag [
	^ #cite
]

{ #category : 'as yet unclassified' }
PRCitationAnnotation >> accept: aVisitor [
	aVisitor visitCitationAnnotation: self
]

{ #category : 'as yet unclassified' }
PRCitationAnnotation >> descriptionRef [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #ref;
		priority: 100;
		label: 'Reference of a citation';
		required: true;
		yourself
]

{ #category : 'as yet unclassified' }
PRCitationAnnotation >> isCitation [
	^true
]
