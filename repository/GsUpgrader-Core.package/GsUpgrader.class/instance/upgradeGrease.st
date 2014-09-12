upgrading
upgradeGrease
  self greaseBaselineLoaded
    ifTrue: [ 
      self
        upgradeMetacello;
        standardUpgrade: 'Grease' repository: self greaseRepositoryDescription ]
    ifFalse: [ self loadGreaseBaseline ].
  self lockGrease