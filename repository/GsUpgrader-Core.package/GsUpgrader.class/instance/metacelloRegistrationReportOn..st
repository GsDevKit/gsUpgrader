reporting
metacelloRegistrationReportOn: strm
  | map |
  strm
    nextPutAll: '-----------------------------';
    cr;
    nextPutAll: 'Metacello Registration REPORT';
    cr;
    nextPutAll: '-----------------------------';
    cr.
  map := Dictionary new.
  MetacelloProjectRegistration registry projectSpecs
    do: [ :projectSpec | 
      MetacelloProjectRegistration
        registrationForProjectSpec: projectSpec
        ifAbsent: [ self error: 'registration for projectSpec: ' projectSpec name , ' not found' ]
        ifPresent: [ :registration :ignored | map at: registration baseName put: registration ] ].
  (map values sorted: [ :a :b | a baseName < b baseName ])
    do: [ :registration | 
      | isLoaded isLocked |
      isLocked := registration isLocked.
      isLoaded := registration loadedInImage.
      isLoaded
        ifFalse: [ strm nextPutAll: '<' ].
      isLocked
        ifTrue: [ strm nextPutAll: '|' ].
      strm nextPutAll: registration baseName.
      isLocked
        ifTrue: [ strm nextPutAll: '|' ].
      strm space.
      (registration respondsTo: #'currentVersionString')
        ifTrue: [ 
          strm
            nextPutAll:
              registration currentVersionString , ' [' , registration currentBranchName , ']' ]
        ifFalse: [ strm nextPutAll: registration projectSpec versionString ].
      isLoaded
        ifFalse: [ strm nextPutAll: '>' ].
      strm cr ]