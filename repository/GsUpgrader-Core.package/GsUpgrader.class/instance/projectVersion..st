private
projectVersion: configurationClassName
  ^ self metacelloPreviewLoaded
    ifTrue: [ 
      (MetacelloProjectRegistration
        projectSpecForClassNamed: configurationClassName
        ifAbsent: [ ^ nil ]) version asMetacelloVersionNumber ]
    ifFalse: [ (Smalltalk at: configurationClassName) project currentVersion ]