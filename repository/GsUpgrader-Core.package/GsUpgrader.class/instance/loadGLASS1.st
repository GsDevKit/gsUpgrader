loading
loadGLASS1
  | metacello |
  self upgradeMetacello.
  metacello := self glass1Locked
    ifTrue: [ self metacelloClass registry ]
    ifFalse: [ 
      self metacelloClass new
        repository: self glass1RepositoryDescription;
        yourself ].
  metacello baseline: 'GLASS1'.
  self
    deploy: [ 
      "May be running with an old version of Metacello so copy the Metacello instance"
      self log: 'Installing GLASS1'.
      metacello copy get.
      metacello copy load ]