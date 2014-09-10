testing
greaseLocked
  (self metacelloClass image
    baseline: [ :spec | spec name = 'Grease' ];
    list)
    do: [ :greaseSpec | 
      greaseSpec isLocked
        ifTrue: [ ^ true ] ].
  ^ false