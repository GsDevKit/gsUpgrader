patching
patchForGsDevKitIssue60Source2
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  "MCPlatformSupport class>>readStreamForUrl:user:passwd:do:"

  ^ 'readStreamForUrl: url user: user passwd: password do: aBlock
  | contents retries retry |
  retries := 0.
  retry := true.
  [  ]
    whileTrue: [ 
      [ 
      contents := HTTPSocket
        httpGet: url
        args: nil
        user: user
        passwd: password.
      retry := false ]
        on: Error
        do: [ :ex | 
          retries := retries + 1.
          retry := retries
            <= 3 Transcript cr;
            show:
                ''Error: '' , ex description printString
                    ,
                      '' during MCPlatformSupport class>>readStreamForUrl:user:passwd:do: for ''
                    , url printString , '' Retrying ('' , retries printString
                    , '')'' ] ].
  ^ contents isString
    ifTrue: [ nil ]
    ifFalse: [ aBlock value: contents ]'