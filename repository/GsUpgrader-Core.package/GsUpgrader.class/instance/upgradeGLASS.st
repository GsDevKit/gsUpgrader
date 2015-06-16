upgrading
upgradeGLASS
  "skip this step if GLASS1 is already loaded"

  | glassVersion originalVersion |
  self glass1Loaded
    ifTrue: [ 
      self inform: 'GLASS1 is loaded. Skipping GLASS upgrade.'.
      ^ self ].
  self metacelloPreviewLoaded
    ifTrue: [ 
      self inform: 'MetacelloPreview is loaded. Skipping GLASS upgrade.'.
      ^ self ].
  glassVersion := self projectVersion: 'ConfigurationOfGLASS'.
  self patchForGsDevKitIssue60.
  self log: 'Detected version ' , glassVersion printString , ' of GLASS'.
  glassVersion versionNumber < '1.0-beta.9.3' asMetacelloVersionNumber
    ifTrue: [ self upgradeGLASS: nil from: glassVersion ]
    ifFalse: [ self log: 'GLASS already upgraded to 1.0-beta.9.3' ]