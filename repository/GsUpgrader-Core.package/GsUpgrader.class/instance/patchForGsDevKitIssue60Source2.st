patching
patchForGsDevKitIssue60Source2
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  "MCPlatformSupport class>>readStreamForUrl:user:passwd:do:"

  ^ 'readStreamForUrl: url user: user passwd: password do: aBlock
  | contents retries retry |
Transcript cr; show: ''readStreamForUrl: [0] '', url printString.
  retries := 0.
retry := true.
  [ retry ]
    whileTrue: [ 
      [ 
Transcript cr; show: ''readStreamForUrl: [1] '', retries printString.
      contents := HTTPSocket
        httpGet: url
        args: nil
        user: user
        passwd: password.
 retry := false]
        on: Error
        do: [ :ex | 
          retries := retries + 1.
Transcript cr; show: ''readStreamForUrl: [2] '', (retries > 3) printString.          retries > 3
            ifTrue: [ ex pass ].
          Transcript
            cr;
            show:
                ''Error: '' , ex description printString
                    ,
                      '' during MCPlatformSupport class>>readStreamForUrl:user:passwd:do: for ''
                    , url printString , '' Retrying ('' , retries printString
                    , '')'' ] ].
  ^ contents isString
    ifTrue: [ nil ]
    ifFalse: [ aBlock value: contents ]'