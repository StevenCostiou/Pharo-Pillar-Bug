"
I ma a phase, I have a block executed when an input is given to me.
"
Class {
	#name : 'LPPhase',
	#superclass : 'LPPipe',
	#instVars : [
		'block'
	],
	#category : 'LightPhaser-Model',
	#package : 'LightPhaser-Model'
}

{ #category : 'initialization' }
LPPhase class >> block: aBlockClosure [
	^ self new block: aBlockClosure
]

{ #category : 'comparing' }
LPPhase >> = aPhase [
	^ self dependencies includesAll: aPhase dependencies
]

{ #category : 'accessing' }
LPPhase >> block: aBlock [
	block := aBlock
]

{ #category : 'executing' }
LPPhase >> executeOn: input [
	^ block value: input
]
