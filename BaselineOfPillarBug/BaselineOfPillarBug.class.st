Class {
	#name : 'BaselineOfPillarBug',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPillarBug',
	#package : 'BaselineOfPillarBug'
}

{ #category : 'baselines' }
BaselineOfPillarBug >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec package: 'LightPhaser-Model'.
		
		spec package: 'Magritte-Model-Core'.
		spec package: 'Magritte-Model-Description'.
		spec package: 'Magritte-Model-Models'.
		spec package: 'Magritte-model-model'.
		spec package: 'Magritte-model-converting'.
		spec package: 'Magritte-morph'.
		spec package: 'Magritte-model-testing'.
		spec package: 'Magritte-Model-Memento'.	
		spec package: 'Magritte-Model-Utility'.
		spec package: 'Magritte-model'.
		spec package: 'Magritte-Model-Exception'.
		spec package: 'Magritte-Model-Visitor'.
		spec package: 'Magritte-model-accessing'.
		spec package: 'Magritte-Model-Accessor'.
		spec package: 'Magritte-model-actions'.
		
		
		spec package: 'PetitParser'.
		
		spec package: 'Cocoon-Core'.
		spec package: 'Cocoon-Core-Configuration'.
		
		spec package: 'Pillar-Model-Core'.
		spec package: 'Pillar-Model-Visitor'.
		spec package: 'Pillar-Model-Description'.
		spec package: 'Pillar-Model-Exceptions'.
		spec package: 'Pillar-Model-Render'.
		spec package: 'Pillar-Model-ScriptLanguage'.
		spec package: 'Pillar-Model-Numbering'.
		spec package: 'Pillar-Model-Document'.
		spec package: 'Pillar-petitpillar'.
		spec package: 'Pillar-ExporterCore'.
		spec package: 'Pillar-ExporterCore-Configuration'.
		spec package: 'Pillar-ExporterMarkdown'.
		spec package: 'Pillar-ExporterHTML'.
		spec package: 'Pillar-ExporterEPub'.
		spec package: 'Pillar-exportertext'.
		spec package: 'Pillar-ExporterAsciiDoc'.
		spec package: 'Pillar-ExporterLaTeX'.
		spec package: 'Pillar-ExporterBeamer'.
		spec package: 'Pillar-Pharo-Tools'.
		
		spec package: 'Pillar-Tests'
		"spec package: 'PillarBug-Reproduction'."
		"spec package: 'Pillar-Tests-ExporterCore-2'." ]
]
