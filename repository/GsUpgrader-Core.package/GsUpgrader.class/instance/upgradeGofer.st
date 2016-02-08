upgrading
upgradeGofer
  "https://github.com/GsDevKit/gsUpgrader/issues/10"

  "should only be called from upgradeGLASS..."

  self log: 'Upgrading Gofer to #stable'.
  [ 
  (self
    goferBlockForUrl: 'http://seaside.gemtalksystems.com/ss/MetacelloRepository')
    value
    package: 'ConfigurationOfGofer';
    load ]
    on: Warning
    do: [ :ex | 
      self log: ex description.
      ex resume ].
  ((Smalltalk at: #'ConfigurationOfGofer') project version: #'stable')
    repositoryOverrides: self repositoryOverrides;
    load