"
I'm an annotation use to create a new Slide for a Slider exporter. 

My tag is: 'slide''.

I can have in parameter:
- a title with the key ""title="" (required, you can write it without the key)
- a label if you want to create a reference to this slide (optional)

Examples: 

${slide:Introduction|label=sld:intro}$

${slide:title=Presentation}$

${slide:title=Conclusion|label=sld:ccl}$
"
Class {
	#name : 'PRSlideTitleAnnotation',
	#superclass : 'PRAbstractAnnotation',
	#category : 'Pillar-Model-Document',
	#package : 'Pillar-Model-Document'
}

{ #category : 'accessing' }
PRSlideTitleAnnotation class >> defaultParameterName [
	"For a slide annotation the default parameter is the title of the slide."

	^ 'title'
]

{ #category : 'protected' }
PRSlideTitleAnnotation class >> tag [
	^ #slide
]

{ #category : 'visiting' }
PRSlideTitleAnnotation >> accept: aVisitor [
	aVisitor visitSlideTitleAnnotation: self
]

{ #category : 'descriptions' }
PRSlideTitleAnnotation >> descriptionLabel [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #label;
		priority: 100;
		label: 'Label of a Slide';
		yourself
]

{ #category : 'descriptions' }
PRSlideTitleAnnotation >> descriptionTitle [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #title;
		priority: 100;
		label: 'Title of a Slide';
		required: true;
		yourself
]

{ #category : 'testing' }
PRSlideTitleAnnotation >> isSlideBeginning [
	^ true
]

{ #category : 'accessing' }
PRSlideTitleAnnotation >> slideAnnotation [
	"I'm here to take care of the case where a paragraph only contains a SlideTitleAnnotation."

	^ self
]
