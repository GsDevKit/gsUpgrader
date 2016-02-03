private
_cacheSentinelExists: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  | cacheBaseDir |
  cacheBaseDir := self
    _upgradeGLASSCacheBaseDir: gsUpgraderCacheDirPath gsUpgraderCacheDirPath.
  ^ cacheBaseDir fileExists: gemstoneVersion , '_sentinel'