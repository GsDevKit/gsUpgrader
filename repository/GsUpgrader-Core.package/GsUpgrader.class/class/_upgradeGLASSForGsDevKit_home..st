private
_upgradeGLASSForGsDevKit_home: gemstoneVersion
  | sysDefaultServer gsUpgraderCacheDirPath |
  sysDefaultServer := GsFile
    _expandEnvVariable: 'GS_SYS_DEFAULT_SERVER'
    isClient: false.
  gsUpgraderCacheDirPath := sysDefaultServer , '/gsUpgrader'.
  (self _cacheSentinelExists: gsUpgraderCacheDirPath forVersion: gemstoneVersion)
    ifTrue: [ 
      self
        _upgradeGLASSLoadingFrom: gsUpgraderCacheDirPath
        forVersion: gemstoneVersion ]
    ifFalse: [ 
      self
        _upgradeGLASSCachingInto: gsUpgraderCacheDirPath
        forVersion: gemstoneVersion ]