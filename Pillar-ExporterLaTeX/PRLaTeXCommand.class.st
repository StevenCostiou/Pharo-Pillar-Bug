"
A LaTeX command
"
Class {
	#name : 'PRLaTeXCommand',
	#superclass : 'PRLaTeXBrush',
	#category : 'Pillar-ExporterLaTeX',
	#package : 'Pillar-ExporterLaTeX'
}

{ #category : 'accessing' }
PRLaTeXCommand >> name: aString [ 
	stream
		<< $\
		<< aString
]
