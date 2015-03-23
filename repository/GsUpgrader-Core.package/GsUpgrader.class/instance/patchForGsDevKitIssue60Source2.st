patching
patchForGsDevKitIssue60Source2
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  "MCHttpRepository>>allFileNames"

  ^ 'allFileNames
  | retries |
  retries := 0.
  [ retries < 3 ]
    whileTrue: [ 
      [ 
      MCPlatformSupport
        readStreamForUrl: self locationWithTrailingSlash , ''?C=M;O=D''
        user: self user
        passwd: self password
        do: [ :str | ^ self parseFileNamesFromStream: str ].
      ^ self error: ''Could not access '' , location ]
        on: Error
        do: [ :ex | 
          Transcript
            cr;
            show:
                ''Error during allFileNames. Retrying ('' , retries printString , '')'' ].
      retries := retries + 1 ]'