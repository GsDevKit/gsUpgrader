testing
greaseConfigurationRegistered
  (self metacelloClass image
    configuration: [ :spec | spec name = 'Grease' ];
    list) do: [ :greaseSpec | ^ true ].
  ^ false