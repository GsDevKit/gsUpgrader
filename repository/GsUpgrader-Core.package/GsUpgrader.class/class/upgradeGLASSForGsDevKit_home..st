GsDevKit_home
upgradeGLASSForGsDevKit_home: gemstoneVersion
  | sysDefaultServer gsUpgraderCacheDirPath |
  sysDefaultServer := GsFile
    _expandEnvVariable: 'GS_SYS_DEFAULT_SERVER'
    isClient: false.
  gsUpgraderCacheDirPath := sysDefaultServer , '/gsUpgrader'.
  (self _cacheSentinelExists: gsUpgraderCacheDirPath forVersion: gemstoneVersion)
    ifTrue: [ 
      self
        gsdkUpgradeGLASSLoadingFrom: gsUpgraderCacheDirPath
        forVersion: gemstoneVersion ]
    ifFalse: [ 
      self
        gsdkUpgradeGLASSCachingInto: gsUpgraderCacheDirPath
        forVersion: gemstoneVersion ]