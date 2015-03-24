patching
patchForGsDevKitIssue60Source2
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  "MCPlatformSupport class>>readStreamForUrl:user:passwd:do:"

  ^ 'readStreamForUrl: url user: user passwd: password do: aBlock
  | contents retries |
  retries := 0.
  [ retries < 3 ]
    whileTrue: [ 
      [ 
      contents := HTTPSocket
        httpGet: url
        args: nil
        user: user
        passwd: password ]
        on: Error
        do: [ :ex | 
          Transcript
            cr;
            show:
                ''Error during MCPlatformSupport class>>readStreamForUrl:user:passwd:do:. Retrying (''
                    , retries printString , '')'' ].
      retries := retries + 1 ].
  ^ contents isString
    ifTrue: [ nil ]
    ifFalse: [ aBlock value: contents ]'