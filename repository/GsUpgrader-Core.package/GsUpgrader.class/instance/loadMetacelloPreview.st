loading
loadMetacelloPreview
  "Bootstrap Metacello Preview, using mcz files (#'previewBootstrap' symbolic version"

  self metacelloPreviewLoaded
    ifTrue: [ 
      self log: 'Metacello Preview already loaded'.
      ^ self ].
  self metacelloBootstrap10beta311Loaded
    ifFalse: [ self loadMetacelloBootstrap10beta311 ].
  self log: 'Loading Metacello Preview'.
  Gofer new
    url: 'http://seaside.gemtalksystems.com/ss/metacello';
    package: 'ConfigurationOfMetacello';
    load.
  self
    deploy: [ 
      "load the Metacello Preview"
      ((Smalltalk at: #'ConfigurationOfMetacello') project
        version: #'previewBootstrap') load.
      (Smalltalk at: #'Metacello') new
        configuration: 'MetacelloPreview';
        version: #'stable';
        repository: self metacelloPreviewRepositoryDescription;
        load ]