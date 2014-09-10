locking
lockGrease
  self greaseLocked
    ifTrue: [ ^ self ].
  self log: 'Locking Grease'.
  Metacello new
    baseline: 'Grease';
    repository: self greaseRepositoryDescription;
    lock