"
I'm an abstract transformer. I assure that the transformation I do don't contains useless paragraph node.
"
Class {
	#name : 'PRTransformerWithoutUselessParagraph',
	#superclass : 'PRNodeTransformer',
	#category : 'Pillar-ExporterCore-Export',
	#package : 'Pillar-ExporterCore',
	#tag : 'Export'
}

{ #category : 'testing' }
PRTransformerWithoutUselessParagraph class >> isAbstract [
	^ self = PRTransformerWithoutUselessParagraph
]

{ #category : 'protected' }
PRTransformerWithoutUselessParagraph >> aboutClass [
	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PRTransformerWithoutUselessParagraph >> replaceParagraph [
	replacement first class = PRParagraph
		ifTrue: [ replacement push: replacement pop first children ]
]

{ #category : 'visitor' }
PRTransformerWithoutUselessParagraph >> specificVisitor: something [
	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PRTransformerWithoutUselessParagraph >> transformParagraph: paragraph [
	^ (paragraph children size = 1 or: (paragraph children size = 2 and: paragraph children last class = PRLineBreak))
		ifTrue: [ self transformParagraphWith1Child: paragraph ]
		ifFalse: [ self transformParagraphWithChildren: paragraph ]
]

{ #category : 'as yet unclassified' }
PRTransformerWithoutUselessParagraph >> transformParagraphWith1Child: paragraph [
	^ paragraph children first class = self aboutClass
		ifTrue: [ 
			replacement push: {paragraph}.
			self specificVisitor: paragraph children first.
			replacement pop ]
		ifFalse: [ self visitNormalNode: paragraph ]
]

{ #category : 'as yet unclassified' }
PRTransformerWithoutUselessParagraph >> transformParagraphWithChildren: paragraph [
	^ (paragraph children contains: [ :each | each class = self aboutClass ])
		ifTrue: [ self visitParagraphWithAnnotation: paragraph ]
		ifFalse: [ self visitNormalNode: paragraph ]
]

{ #category : 'visiting-document' }
PRTransformerWithoutUselessParagraph >> visitDocumentGroup: aGroup [
	aGroup
		setChildren:
			(aGroup children
				flatCollect: [ :child | 
					child class = PRParagraph
						ifTrue: [ self transformParagraph: child ]
						ifFalse: [ self visitNormalNode: child ] ])
]

{ #category : 'visitor' }
PRTransformerWithoutUselessParagraph >> visitNormalNode: node [
	replacement push: {node}.
	self visit: node.
	^ replacement pop
]

{ #category : 'visitor' }
PRTransformerWithoutUselessParagraph >> visitParagraphWithAnnotation: paragraph [
	^ {(paragraph
		setChildren:
			(paragraph children
				flatCollect: [ :child | 
					child class = self aboutClass
						ifTrue: [ 
							replacement push: {child}.
							self visit: child.
							self replaceParagraph.
							replacement pop ]
						ifFalse: [ self visitNormalNode: child ] ]))}
]
