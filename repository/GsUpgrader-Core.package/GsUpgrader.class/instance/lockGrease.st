locking
lockGrease
  self greaseLocked
    ifTrue: [ ^ self ].
  self log: 'Locking Grease'.
  self
    deploy: [ 
      self greaseConfigurationRegistered
        ifTrue: [ 
          "workaround for https://github.com/dalehenrich/metacello-work/issues/352"
          self metacelloClass image
            configuration: 'Grease';
            unregister ].
      self metacelloClass new
        baseline: 'Grease';
        repository: self greaseRepositoryDescription;
        lock ]