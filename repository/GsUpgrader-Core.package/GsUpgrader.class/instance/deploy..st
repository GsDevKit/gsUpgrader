private
deploy: aBlock
  (Smalltalk at: #'GsDeployer' ifAbsent: [  ])
    ifNil: [ 
      | oldAutoCommit oldAutoMigrate |
      oldAutoCommit := MCPlatformSupport autoCommit.
      oldAutoMigrate := MCPlatformSupport autoMigrate.
      MCPlatformSupport autoCommit: true.
      MCPlatformSupport autoMigrate: true.
      [ MCPlatformSupport commitOnAlmostOutOfMemoryDuring: aBlock ]
        ensure: [ 
          MCPlatformSupport autoCommit: oldAutoCommit.
          MCPlatformSupport autoMigrate: oldAutoMigrate ] ]
    ifNotNil: [ :deployerClass | deployerClass deploy: aBlock ]