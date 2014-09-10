loading
loadGLASS1
  | metacello |
  self upgradeMetacello.
  metacello := Metacello new
    baseline: 'GLASS1';
    repository: self glass1RepositoryDescription;
    yourself.
  GsDeployer
    deploy: [ 
      self log: 'Installing GLASS1'.
      metacello copy get.
      metacello copy load ]