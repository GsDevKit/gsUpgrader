testing
glass1Loaded
  Smalltalk
    at: #'BaselineOfGLASS1'
    ifPresent: [ :ignored | 
      Smalltalk
        at: #'MetacelloProjectRegistration'
        ifPresent: [ :cls | 
          (cls registrationForClassNamed: 'BaselineOfGLASS1' ifAbsent: [  ])
            ifNotNil: [ :registration | 
              registration loadedInImage
                ifTrue: [ ^ true ] ] ] ].
  ^ false