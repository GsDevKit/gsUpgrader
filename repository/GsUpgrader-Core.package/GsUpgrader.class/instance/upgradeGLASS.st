upgrading
upgradeGLASS
  "skip this step if GLASS1 is already loaded"

  | glassVersion |
  self glass1Loaded
    ifTrue: [ 
      self inform: 'GLASS1 is loaded. Skipping GLASS upgrade.'.
      ^ self ].
  glassVersion := ConfigurationOfGLASS project currentVersion.
  self metacelloPreviewLoaded
    ifTrue: [ 
      self inform: 'MetacelloPreview is loaded. Skipping GLASS upgrade.'.
      ^ self ].
  glassVersion versionNumber < '1.0-beta.9.3' asMetacelloVersionNumber
    ifTrue: [ 
      self log: 'Upgrading GLASS to 1.0-beta.9.3'.
      GsDeployer
        deploy: [ 
          Gofer new
            package: 'ConfigurationOfGLASS';
            url: 'http://seaside.gemtalksystems.com/ss/MetacelloRepository';
            load.
          (((System stoneVersionAt: 'gsVersion') beginsWith: '2.')
            and: [ glassVersion versionNumber < '1.0-beta.9.2' asMetacelloVersionNumber ])
            ifTrue: [ ((Smalltalk at: #'ConfigurationOfGLASS') project version: '1.0-beta.9.2') load ].
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.3') load ] ]
    ifFalse: [ self log: 'GLASS already upgraded to 1.0-beta.9.3' ]