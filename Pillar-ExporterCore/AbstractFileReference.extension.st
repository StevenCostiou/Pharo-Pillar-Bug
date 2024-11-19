Extension { #name : 'AbstractFileReference' }

{ #category : '*pillar-exportercore' }
AbstractFileReference >> pillarWriteDuring: aBlock [
	self parent ensureCreateDirectory.
	self
		ensureDelete;
		writeStreamDo: aBlock
]
