private
gsdkUpgradeGLASSLoadingFrom: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  "use <repoPath> as repositoryOverrides for loads."

  | repo |
  repo := MCDirectoryRepository new
    directory: (self _upgradeGLASSCacheDir: gsUpgraderCacheDirPath).
  self new
    gsUpgraderCacheDirPath: gsUpgraderCacheDirPath;
    repositoryOverride: repo;
    upgradeGLASS