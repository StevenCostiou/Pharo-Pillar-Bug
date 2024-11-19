"
I generate a documentation of the parameters of a CCConfiguration.

To use it it's simple. 
On a property's method add this pragma: 

	<cocoonParameter: 'The documentation of my property'>

The default value's property need to be named like this: if your property is 'author' so the default value's method will be named 'defaultAuthor'.
Inside the default method add this pragma: 

	<cocoonDefaultParameter: 'The description of the default value.'>

If the default value is a litteral you can also write 

	<cocoonDefaultParameter: ''>

This will print the litteral value.

Now you can generate your documentation like this.

Create a stream and use this simple command:

	stream := String new writeStream.
	CCDocumentationGeneration of: myClassWhoExtendsCCConfiguration on: stream.

"
Class {
	#name : 'CCDocumentationGeneration',
	#superclass : 'MAVisitor',
	#instVars : [
		'stream'
	],
	#category : 'Cocoon-Core-Utiles',
	#package : 'Cocoon-Core',
	#tag : 'Utiles'
}

{ #category : 'class initialization' }
CCDocumentationGeneration class >> of: aClassConfiguration on: aStream [ 	
	"I generate the documentation of the parameters of a configuration on a Stream."
	
	^self new 
		stream: aStream;
		generateDocOf: aClassConfiguration;
		stream
]

{ #category : 'accessing' }
CCDocumentationGeneration >> defaultCommentFrom: aDescription [
	^ aDescription cocoonDefaultDocumentation ifNil: [ '==' , aDescription default printString , '==' ]
]

{ #category : 'action' }
CCDocumentationGeneration >> generateDocOf: aClassConfiguration [
	"I return a Stream with the documentation of the properties of Cocoon."

	self visitAll: (self sortedChildrenOf: aClassConfiguration).
	^ self stream
]

{ #category : 'initialization' }
CCDocumentationGeneration >> initialize [
	super initialize.
	self stream: String new writeStream
]

{ #category : 'action' }
CCDocumentationGeneration >> sortedChildrenOf: aConfigurationClass [
	^ aConfigurationClass new magritteDescription children
		sorted: [ :description1 :description2 | description1 accessor readSelector < description2 accessor readSelector ]
]

{ #category : 'accessing' }
CCDocumentationGeneration >> stream [
	^ stream
]

{ #category : 'accessing' }
CCDocumentationGeneration >> stream: anObject [
	stream := anObject
]

{ #category : 'visiting-description' }
CCDocumentationGeneration >> visitDescription: aDescription [
	self writeAccesorOf: aDescription.
	self writeCommentOf: aDescription.
	self writeDefaultCommentFor: aDescription
]

{ #category : 'writing' }
CCDocumentationGeneration >> writeAccesorOf: aDescription [
	stream
		nextPutAll: '!!!! ';
		nextPutAll: aDescription accessor readSelector;
		lf
]

{ #category : 'writing' }
CCDocumentationGeneration >> writeCommentOf: aDescription [
	| parameterComment |
	parameterComment := aDescription cocoonDocumentation.
	stream
		nextPutAll: '@sec:confParam:';
		nextPutAll: aDescription accessor readSelector;
		lf;
		nextPutAll:
				(parameterComment = aDescription class defaultCocoonDocumentation
						ifTrue: [ 'uncommented' ]
						ifFalse: [ parameterComment ]);
		lf;
		lf
]

{ #category : 'writing' }
CCDocumentationGeneration >> writeDefaultCommentFor: aDescription [
	stream
		lf;
		lf;
		nextPutAll: 'Default value: ';
		nextPutAll: (self defaultCommentFrom: aDescription);
		lf;
		lf
]
