upgrading
upgradeGLASS1
  | metacello projectSpec |
  self glass1Loaded
    ifFalse: [ 
      self upgradeGLASS.
      self glass1Present
        ifFalse: [ 
          ^ self
            loadGLASS1;
            upgradeGrease ] ].
  self
    upgradeMetacello;
    upgradeGrease;
    standardUpgrade: 'GLASS1' repository: self glass1RepositoryDescription