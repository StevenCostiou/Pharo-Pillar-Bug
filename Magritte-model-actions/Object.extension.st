Extension { #name : 'Object' }

{ #category : '*magritte-model-actions' }
Object >> magritteActionDescriptions [

	^ self uniqueActionSelectors collect: [ :each | self perform: each ]
]

{ #category : '*magritte-model-actions' }
Object >> uniqueActionSelectors [

	| descriptionPragmas selectors |	
	descriptionPragmas := Pragma 
		allNamed: #magritteActionDescription
		from: self class to: Object.
		
	selectors := descriptionPragmas collect: [ :each | each method selector ].
	
	^ Set withAll: selectors
]
