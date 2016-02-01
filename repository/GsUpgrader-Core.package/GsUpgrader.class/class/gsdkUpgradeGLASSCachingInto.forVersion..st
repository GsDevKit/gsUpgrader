GsDevKit_home
gsdkUpgradeGLASSCachingInto: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  "Use <cacheDirectoryPath> as the package cache for upgrade"

  | oldCache newCache cacheDir |
  cacheDir := ServerFileDirectory
    on: gsUpgraderCacheDirPath , self monticelloBaseDir , gemstoneVersion.
  cacheDir assureExistence.
  oldCache := MCCacheRepository default.
  [ 
  newCache := MCCacheRepository new directory: cacheDir.
  MCCacheRepository setDefault: newCache.
  self new
    gsUpgraderCacheDirPath: gsUpgraderCacheDirPath;
    upgradeGLASS ]
    ensure: [ MCCacheRepository setDefault: oldCache ]