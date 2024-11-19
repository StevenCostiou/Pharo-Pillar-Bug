"
I include a reference to a pillar file. With me we can add a transformation to remplace an annotation to a pillar file by his tree.

My tag is: 'inputFile''.

I can have in parameter:
- a path to a file with the key ""value="" (required, you can write it without the key)

Examples: 

${inputFile:myFile.pillar}$

${inputFile:value=directory/myFile.pillar}$
"
Class {
	#name : 'PRInputFileAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'protected' }
PRInputFileAnnotation class >> tag [
	^ #inputFile
]

{ #category : 'visiting' }
PRInputFileAnnotation >> accept: aVisitor [
	aVisitor visitInputFileAnnotation: self
]

{ #category : 'acessing-magritte' }
PRInputFileAnnotation >> descriptionValue [
	<magritteDescription>
	^ PRMagrittePathDescription new
		accessor: #value;
		priority: 100;
		label: 'Path of the inputFile';
		yourself
]

{ #category : 'private' }
PRInputFileAnnotation >> errorFileNotFound: aFile [
	PRInputFileError signal: 'File at: ' , aFile fullName , ' not found.'
]

{ #category : 'accessing' }
PRInputFileAnnotation >> fileWithConfiguration: aConfiguration [
	"I search my file."

	^ aConfiguration baseDirectory resolve: (self parameters at: 'value')
]
