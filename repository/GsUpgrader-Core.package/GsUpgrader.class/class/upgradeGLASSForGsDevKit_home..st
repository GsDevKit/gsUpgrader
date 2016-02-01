GsDevKit_home
upgradeGLASSForGsDevKit_home: gemstoneVersion
  | sysDefaultServer gsUpgraderCacheDirPath cacheDir |
  sysDefaultServer := GsFile
    _expandEnvVariable: 'GS_SYS_DEFAULT_SERVER'
    isClient: false.
  gsUpgraderCacheDirPath := sysDefaultServer , '/gsUpgrader'.
  cacheDir := ServerFileDirectory
    on: gsUpgraderCacheDirPath , self monticelloBaseDir , gemstoneVersion.
  cacheDir exists
    ifTrue: [ 
      self
        gsdkUpgradeGLASSLoadingFrom: gsUpgraderCacheDirPath
        forVersion: gemstoneVersion ]
    ifFalse: [ 
      self
        gsdkUpgradeGLASSCachingInto: gsUpgraderCacheDirPath
        forVersion: gemstoneVersion ]