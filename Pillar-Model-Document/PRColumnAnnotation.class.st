"
I am an annotation that mark the beginning of a new column.

My tag is: 'column''.

I can have in parameter:
- a wodth with the key ""width="" (required, you can write it without the key, take an integer between 0 and 100)

Examples: 

${column:50}$

${column:width=50}$
"
Class {
	#name : 'PRColumnAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'accessing' }
PRColumnAnnotation class >> defaultParameterName [
	^ 'width'
]

{ #category : 'protected' }
PRColumnAnnotation class >> tag [
	^ #column
]

{ #category : 'accessing' }
PRColumnAnnotation >> columnAnnotation [
	"This is a hack, we will need to clean that."

	^ self
]

{ #category : 'descriptions' }
PRColumnAnnotation >> descriptionWidth [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #width;
		priority: 100;
		label: 'Width of the column';
		required: true;
		min: 0 max: 100;
		yourself
]

{ #category : 'testing' }
PRColumnAnnotation >> isColumnBeginning [
	^ true
]
