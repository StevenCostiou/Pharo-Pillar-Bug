Class {
	#name : 'PRDependencies',
	#superclass : 'PRVisitor',
	#instVars : [
		'cachedDependencies'
	],
	#category : 'Pillar-Model-Visitor',
	#package : 'Pillar-Model-Visitor'
}

{ #category : 'accessing' }
PRDependencies >> cachedDependencies [
	^ cachedDependencies 
]

{ #category : 'visiting' }
PRDependencies >> start: aDocument [
	cachedDependencies := Set new.
	super start: aDocument.
	^ cachedDependencies.
]
