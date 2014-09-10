testing
metacelloPreviewLoaded
  Smalltalk
    at: #'BaselineOfMetacello'
    ifPresent: [ :ignored | 
      Smalltalk
        at: #'MetacelloProjectRegistration'
        ifPresent: [ :cls | 
          (cls registrationForClassNamed: 'BaselineOfMetacello' ifAbsent: [  ])
            ifNotNil: [ :registration | ^ registration loadedInImage ] ] ].
  ^ false