private
gsdkUpgradeGLASSCachingInto: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  "Use <cacheDirectoryPath> as the package cache for upgrade"

  | oldCache newCache cacheDir |
  cacheDir := self _upgradeGLASSCacheDir: gsUpgraderCacheDirPath.
  cacheDir assureExistence.
  oldCache := MCCacheRepository default.
  [ 
  newCache := MCCacheRepository new directory: cacheDir.
  MCCacheRepository setDefault: newCache.
  self new
    gsUpgraderCacheDirPath: gsUpgraderCacheDirPath;
    upgradeGLASS ]
    ensure: [ MCCacheRepository setDefault: oldCache ].
  self _createCacheSentinel: gsUpgraderCacheDirPath forVersion: gemstoneVersion