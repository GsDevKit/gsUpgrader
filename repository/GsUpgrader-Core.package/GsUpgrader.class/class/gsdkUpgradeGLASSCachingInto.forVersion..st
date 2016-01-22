GsDevKit_home
gsdkUpgradeGLASSCachingInto: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  "Use <cacheDirectoryPath> as the package cache for upgrade"

  | oldCache newCache |
  oldCache := MCCacheRepository default.
  [ 
  newCache := MCCacheRepository new
    directory:
      (ServerFileDirectory
        on: gsUpgraderCacheDirPath , self monticelloBaseDir , gemstoneVersion).
  MCCacheRepository setDefault: newCache.
  self new
    gsUpgraderCacheDirPath: gsUpgraderCacheDirPath;
    upgradeGLASS ]
    ensure: [ MCCacheRepository setDefault: oldCache ]