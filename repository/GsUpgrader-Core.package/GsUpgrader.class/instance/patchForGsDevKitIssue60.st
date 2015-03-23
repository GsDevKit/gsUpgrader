patching
patchForGsDevKitIssue60
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  | protocol |
  protocol := 'GsDevKit Issue60 patch'.
  Smalltalk
    at: #'HTTPSocket'
    ifPresent: [ :cls | 
      self log: 'Installing patchForGsDevKitIssue60: ' cls name asString.
      cls compile: self patchForGsDevKitIssue60Source1 classified: protocol ].
  Smalltalk
    at: #'MCHttpRepository'
    ifPresent: [ :cls | 
      self log: 'Installing patchForGsDevKitIssue60: ' cls name asString.
      cls compile: self patchForGsDevKitIssue60Source2 classified: protocol ]