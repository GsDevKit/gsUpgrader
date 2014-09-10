loading
loadMetacelloPreview
  "Bootstrap Metacello Preview, using mcz files (#'previewBootstrap' symbolic version"

  self metacelloPreviewLoaded
    ifTrue: [ 
      self log: 'Metacello Preview already loaded'.
      ^ self ].
  self log: 'Loading Metacello Preview'.
  Gofer new
    gemsource: 'metacello';
    package: 'ConfigurationOfMetacello';
    load.
  GsDeployer
    deploy: [ 
      "load the Metacello Preview"
      ((Smalltalk at: #'ConfigurationOfMetacello') project
        version: #'previewBootstrap') load.
      (Smalltalk at: #'Metacello') new
        configuration: 'MetacelloPreview';
        version: #'stable';
        repository: self metacelloPreviewRepositoryDescription;
        load ]