private
registrationFor: className
  Smalltalk
    at: className
    ifPresent: [ :ignored | 
      Smalltalk
        at: #'MetacelloProjectRegistration'
        ifPresent: [ :cls | 
          (cls registrationForClassNamed: className ifAbsent: [  ])
            ifNotNil: [ :registration | ^ registration ] ] ].
  ^ nil