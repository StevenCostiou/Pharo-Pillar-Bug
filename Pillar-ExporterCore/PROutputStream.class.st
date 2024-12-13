"
I represent a very simple interface for writing text to a stream.

I'm associated with a configuration which knows some details about the output stream (e.g., the line ending convention)
"
Class {
	#name : 'PROutputStream',
	#superclass : 'PRBasicObject',
	#instVars : [
		'stream',
		'configuration'
	],
	#category : 'Pillar-ExporterCore-Utilities',
	#package : 'Pillar-ExporterCore',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
PROutputStream class >> on: aWriteStream [ 
	^ self new
		setStream: aWriteStream;
		yourself
]

{ #category : 'streaming' }
PROutputStream >> << anObject [
	anObject isBlock
		ifTrue: anObject
		ifFalse: [ stream << anObject ]
]

{ #category : 'accessing' }
PROutputStream >> configuration [
	^ configuration ifNil: [ configuration := PRPillarConfiguration new ]
]

{ #category : 'accessing' }
PROutputStream >> configuration: aConfiguration [
	^ configuration := aConfiguration
]

{ #category : 'streaming' }
PROutputStream >> contents [
	^ stream contents
]

{ #category : 'accessing' }
PROutputStream >> flush [
	stream flush
]

{ #category : 'testing' }
PROutputStream >> isEmpty [
	
	^ stream isEmpty
]

{ #category : 'streaming' }
PROutputStream >> newLine [
	self << self configuration newLine
]

{ #category : 'initialize-release' }
PROutputStream >> setStream: aWriteStream [
	stream := aWriteStream
]

{ #category : 'streaming' }
PROutputStream >> space [
	stream space
]

{ #category : 'private' }
PROutputStream >> stream [

	^ stream
]

{ #category : 'streaming' }
PROutputStream >> trimLastNewLine [
	| newLine |
	newLine := self configuration newLine.
	(newLine isEmpty or: [ stream position < newLine size ])
		ifTrue: [ ^ self ].
	stream position: stream position - newLine size.
]
