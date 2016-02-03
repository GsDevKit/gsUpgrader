private
_createCacheSentinel: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  | cacheBaseDir |
  cacheBaseDir := self
    _upgradeGLASSCacheBaseDir: gsUpgraderCacheDirPath gsUpgraderCacheDirPath.
  (cacheBaseDir forceNewFileNamed: gemstoneVersion , '_sentinel') close