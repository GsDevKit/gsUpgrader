testing
gsDevKitLocked
  (self metacelloClass registry
    baseline: [ :spec | spec name = 'GsDevKit' ];
    list)
    do: [ :gsDevKitSpec | 
      gsDevKitSpec isLocked
        ifTrue: [ ^ true ] ].
  ^ false