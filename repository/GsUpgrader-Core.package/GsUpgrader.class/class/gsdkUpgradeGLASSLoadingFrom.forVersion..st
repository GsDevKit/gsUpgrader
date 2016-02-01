private
gsdkUpgradeGLASSLoadingFrom: gsUpgraderCacheDirPath forVersion: gemstoneVersion
  "use <repoPath> as repositoryOverrides for loads."

  | repo |
  repo := MCDirectoryRepository new
    directory:
      (ServerFileDirectory
        on: gsUpgraderCacheDirPath , self monticelloBaseDir , gemstoneVersion).
  self new
    gsUpgraderCacheDirPath: gsUpgraderCacheDirPath;
    repositoryOverride: repo;
    upgradeGLASS