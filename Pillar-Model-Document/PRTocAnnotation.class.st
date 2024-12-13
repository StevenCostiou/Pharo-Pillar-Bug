"
I'm an annotation use to generate some Table of contents. 

My tag is: 'toc''.

I have this form : 

${toc:depthLevel=x|level=y|highlight=true}$

The depthLevel is use to know the min level of title i need to use. I'll not print title lower than it.

The level is use to know what i need to print. I stay on the section x-1 and I stop at the next y title.

Highlight allow to highlight the current section (this might be vanish in the futur).

Example:

${toc:depthLevel=5|level=3|highlight=true}$

"
Class {
	#name : 'PRTocAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'protected' }
PRTocAnnotation class >> tag [
	^ #toc
]

{ #category : 'visiting' }
PRTocAnnotation >> accept: aVisitor [
	aVisitor visitTOCAnnotation: self
]

{ #category : 'descriptions' }
PRTocAnnotation >> descriptionDepthLevel [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #depthLevel;
		priority: 100;
		label: 'Depth Level of the ToC';
		required: true;
		min: 0 max: 7;
		yourself
]

{ #category : 'descriptions' }
PRTocAnnotation >> descriptionHighlight [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #highlight;
		priority: 100;
		label: 'Highlight';
		yourself
]

{ #category : 'descriptions' }
PRTocAnnotation >> descriptionLevel [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #level;
		priority: 100;
		label: 'Level of the ToC';
		required: true;
		min: 0 max: 7;
		yourself
]

{ #category : 'as yet unclassified' }
PRTocAnnotation >> todo [
	self flag: #todo "add title to the parameters."
]
