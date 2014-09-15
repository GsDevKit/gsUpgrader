locking
lockGrease
  self greaseLocked
    ifTrue: [ ^ self ].
  self log: 'Locking Grease'.
  self
    deploy: [ 
      self metacelloClass new
        baseline: 'Grease';
        repository: self greaseRepositoryDescription;
        lock ]