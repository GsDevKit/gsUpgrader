private
_createCacheSentinel: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  | cacheBaseDir |
  cacheBaseDir := self _upgradeGLASSCacheBaseDir: gsUpgraderCacheDirPath.
  (cacheBaseDir forceNewFileNamed: gemstoneVersion , '_sentinel') close