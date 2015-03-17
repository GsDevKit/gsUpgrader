testing
glass1Locked
  (self metacelloClass image
    baseline: [ :spec | spec name = 'GLASS1' ];
    list)
    do: [ :glass1Spec | 
      glass1Spec isLocked
        ifTrue: [ ^ true ] ].
  ^ false