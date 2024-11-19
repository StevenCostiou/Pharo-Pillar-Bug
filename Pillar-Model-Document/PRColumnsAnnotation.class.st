"
I am an annotation that mark the beginning of a columns environement.

My tag is: 'columns''.

Example: 

${columns}$
"
Class {
	#name : 'PRColumnsAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'protected' }
PRColumnsAnnotation class >> tag [
	^ #columns
]

{ #category : 'as yet unclassified' }
PRColumnsAnnotation >> isColumnsBeginning [
	^ true
]
