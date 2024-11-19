"
A LaTeX environment

Instance Variables
	name:		<Object>

name
	- xxxxx

"
Class {
	#name : 'PRLaTeXEnvironment',
	#superclass : 'PRLaTeXBrush',
	#instVars : [
		'name'
	],
	#category : 'Pillar-ExporterLaTeX',
	#package : 'Pillar-ExporterLaTeX'
}

{ #category : 'accessing' }
PRLaTeXEnvironment >> name: aString [
	name := aString.
	stream newLine.
	stream << '\begin{' << aString << '}'
]

{ #category : 'accessing' }
PRLaTeXEnvironment >> with: aBlock [
	stream newLine.
	aBlock value.
	(stream << '\end{' << name)
		<< '}';
		newLine
]
