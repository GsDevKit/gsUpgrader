upgrading
upgradeGsDevKit
  | metacello projectSpec |
  self gsDevKitLoaded
    ifFalse: [ 
      self upgradeGLASS.
      self gsDevKitPresent
        ifFalse: [ 
          ^ self
            loadGsDevKit;
            upgradeGrease ] ].
  self
    upgradeMetacello;
    upgradeGrease;
    standardUpgrade: 'GsDevKit' repository: self gsDevKitRepositoryDescription