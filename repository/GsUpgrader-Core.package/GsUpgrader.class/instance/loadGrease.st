loading
loadGrease
  | metacello |
  self upgradeMetacello.
  metacello := self greaseLocked
    ifTrue: [ self metacelloClass registry ]
    ifFalse: [ 
      self metacelloClass new
        repository: self greaseRepositoryDescription;
        yourself ].
  metacello baseline: 'Grease'.
  self
    deploy: [ 
      self log: 'Installing Grease'.
      metacello copy get.
      metacello copy load ]