upgrading
upgradeGofer
  "https://github.com/GsDevKit/gsUpgrader/issues/10"

  "should only be called from upgradeGLASS..."

  self log: 'Upgrading Gofer to #stable'.
  [ 
  Gofer new
    url: 'http://seaside.gemtalksystems.com/ss/MetacelloRepository';
    package: 'ConfigurationOfGofer';
    load ]
    on: Warning
    do: [ :ex | 
      self log: ex description.
      ex resume ].
  ((Smalltalk at: #'ConfigurationOfGofer') project version: #'stable') load