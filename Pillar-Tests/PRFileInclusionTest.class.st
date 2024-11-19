"
Tests for PRFileInclusion
"
Class {
	#name : 'PRFileInclusionTest',
	#superclass : 'PRNodeTransformerTest',
	#instVars : [
		'directory'
	],
	#category : 'Pillar-Tests',
	#package : 'Pillar-Tests'
}

{ #category : 'private' }
PRFileInclusionTest >> actualClass [
	^ PRFileInclusion
]

{ #category : 'accessing' }
PRFileInclusionTest >> configuration [
	^ super configuration
		"we disable these phases as they pollute the tests"
		disabledPhases: #('sections'  'justKeepHeaders');
		yourself
]

{ #category : 'running' }
PRFileInclusionTest >> createFile1 [
	| stream |
	stream := (directory / 'foo.pillar') writeStream.
	stream nextPutAll: '!!Hello World'.
	stream close
]

{ #category : 'running' }
PRFileInclusionTest >> createFile2 [
	| stream |
	stream := (directory / 'bar.pillar') writeStream.
	stream nextPutAll: '${inputFile:foo.pillar}$' , Smalltalk os lineEnding , '!!Bye World'.
	stream close
]

{ #category : 'running' }
PRFileInclusionTest >> createFile3 [
	| stream |
	stream := (directory / 'timoleon.pillar') writeStream.
	stream nextPutAll: '!!Hello World' , Smalltalk os lineEnding , 'test'.
	stream close
]

{ #category : 'running' }
PRFileInclusionTest >> createFile4 [
	| stream |
	(directory / 'tata') ensureCreateDirectory.
	stream := (directory / 'tata' / 'toto.pillar') writeStream.
	stream nextPutAll: '+fig.png|width=50+'.
	stream close
]

{ #category : 'helpers' }
PRFileInclusionTest >> fileInclusionTo: aString [
	^ PRInputFileAnnotation
		parameters:
			(SmallDictionary new
				at: 'value' put: aString;
				yourself)
]

{ #category : 'running' }
PRFileInclusionTest >> setUp [
	super setUp.
	directory := FileSystem workingDirectory.
	self createFile1.
	self createFile2.
	self createFile3.
	self createFile4
]

{ #category : 'running' }
PRFileInclusionTest >> tearDown [
	super tearDown.
	(directory / 'foo.pillar') delete.
	(directory / 'bar.pillar') delete.
	(directory / 'tata/toto.pillar') delete.
	(directory / 'tata') ensureDelete.
	(directory / 'timoleon.pillar') delete
]

{ #category : 'tests' }
PRFileInclusionTest >> testInclude1File [
	| input result |
	input := PRDocument with: (self fileInclusionTo: 'foo.pillar').
	result := PRDocument
		with:
			(PRHeader new
				level: 2;
				add: (PRText content: 'Hello World');
				yourself).
	self assert: (self executePhase: input) equals: result
]

{ #category : 'tests' }
PRFileInclusionTest >> testInclude1FileInto1Include [
	| input result |
	input := PRDocument with: (self fileInclusionTo: 'bar.pillar').
	result := PRDocument new
		add:
			(PRHeader new
				level: 2;
				add: (PRText content: '\Hello World');
				yourself);
		add:
			(PRHeader new
				level: 2;
				add: (PRText content: '\Bye World');
				yourself);
		yourself.
	self assert: (self executePhase: input) equals: result
]

{ #category : 'tests' }
PRFileInclusionTest >> testInclude1FileWithFigure [
	| input result |
	input := PRDocument with: (self fileInclusionTo: 'tata/toto.pillar').
	result := PRDocument new
		add:
			(PRParagraph new
				add:
					(PRFigure new
						reference: 'tata/fig.png';
						parameterAt: 'width' put: '50';
						yourself);
				yourself);
		yourself.
	self assert: (self executePhase: input) equals: result
]
