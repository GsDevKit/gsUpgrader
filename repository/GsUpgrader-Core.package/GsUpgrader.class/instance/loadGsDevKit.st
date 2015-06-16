loading
loadGsDevKit
  | metacello |
  self upgradeMetacello.
  metacello := self gsDevKitLocked
    ifTrue: [ self metacelloClass registry ]
    ifFalse: [ 
      self metacelloClass new
        repository: self gsDevKitRepositoryDescription;
        yourself ].
  metacello baseline: 'GsDevKit'.
  self
    deploy: [ 
      "May be running with an old version of Metacello so copy the Metacello instance"
      self log: 'Installing GsDevKit'.
      metacello copy get.
      metacello copy load ]