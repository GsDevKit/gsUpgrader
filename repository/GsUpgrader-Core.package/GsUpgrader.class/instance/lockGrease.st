locking
lockGrease
  self greaseLocked
    ifTrue: [ ^ self ].
  self log: 'Locking Grease'.
  GsDeployer
    deploy: [ 
      self metacelloClass new
        baseline: 'Grease';
        repository: self greaseRepositoryDescription;
        lock ]