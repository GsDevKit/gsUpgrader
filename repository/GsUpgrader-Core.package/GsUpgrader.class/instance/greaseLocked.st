testing
greaseLocked
  (Metacello image
    baseline: [ :spec | spec name = 'Grease' ];
    list)
    do: [ :greaseSpec | 
      greaseSpec isLocked
        ifTrue: [ ^ true ] ].
  ^ false