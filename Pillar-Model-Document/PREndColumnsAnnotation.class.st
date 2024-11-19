"
I am an annotation that mark the end of a columns environement.

My tag is: 'endColumns''.

Example: 

${endColumns}$
"
Class {
	#name : 'PREndColumnsAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'protected' }
PREndColumnsAnnotation class >> tag [ 
	^ #endColumns
]

{ #category : 'testing' }
PREndColumnsAnnotation >> isColumnsEnding [
	^ true
]
