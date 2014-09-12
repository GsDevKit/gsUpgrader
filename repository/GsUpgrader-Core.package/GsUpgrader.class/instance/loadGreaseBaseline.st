loading
loadGreaseBaseline
  | metacello |
  self upgradeMetacello.
  metacello := self metacelloClass new
    baseline: 'Grease';
    repository: self greaseRepositoryDescription;
    yourself.
  GsDeployer
    deploy: [ 
      self log: 'Installing Grease'.
      metacello copy get.
      metacello copy load ]