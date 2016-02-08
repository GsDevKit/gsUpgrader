private
_cacheSentinelExists: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  | cacheBaseDir |
  cacheBaseDir := self _upgradeGLASSCacheBaseDir: gsUpgraderCacheDirPath.
  ^ cacheBaseDir fileExists: gemstoneVersion , '_sentinel'