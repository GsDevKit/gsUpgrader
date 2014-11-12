loading
loadGsDevKit
  | metacello |
  self upgradeMetacello.
  metacello := self metacelloClass new
    baseline: 'GsDevKit';
    repository: self gsDevKitRepositoryDescription;
    yourself.
  self
    deploy: [ 
      self log: 'Installing GsDevKit'.
      metacello
        get;
        load ]