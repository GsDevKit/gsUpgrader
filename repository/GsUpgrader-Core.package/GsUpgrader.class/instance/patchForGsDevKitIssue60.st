patching
patchForGsDevKitIssue60
  "https://github.com/GsDevKit/GsDevKit/issues/60"

  Smalltalk
    at: #'HTTPSocket'
    ifPresent: [ :cls | 
      | protocol |
      self log: 'Installing patchForGsDevKitIssue60'.
      protocol := 'GsDevKit Issue60 patch'.
      cls compile: self patchForGsDevKitIssue60Source1 classified: protocol.
      cls compile: self patchForGsDevKitIssue60Source2 classified: protocol ]