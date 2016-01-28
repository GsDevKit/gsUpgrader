private
ifNeededDownloadMetacelloPreviewFor: metacelloPreviewStableVersionString
  | path zipUrl pid zipFileName |
  path := gsUpgraderCacheDirPath
    , '/caches/upgradeGLASS/metacelloPreview/metacello-work-'
    , metacelloPreviewStableVersionString.
  (ServerFileDirectory on: path) exists
    ifTrue: [ 
      "already downloaded"
      ^ self ].
  zipUrl := 'https://github.com/dalehenrich/metacello-work/archive/v'
    , metacelloPreviewStableVersionString , '.zip'.
  pid := (System gemVersionReport at: 'processId') printString.
  zipFileName := '/tmp/gsUpgrader-' , pid , '.zip'.
  (MetacelloPlatform current respondsTo: #'downloadFile:to:')
    ifTrue: [ 
      "older version of GemStone"
      MetacelloPlatform current downloadFile: zipUrl to: zipFileName.
      MetacelloPlatform current
        extractRepositoryFrom: zipFileName
        to: gsUpgraderCacheDirPath , '/caches/upgradeGLASS/metacelloPreview' ]
    ifFalse: [ 
      MetacelloPlatform current downloadBasicFile: zipUrl to: zipFileName.
      MetacelloPlatform current
        extractRepositoryFrom: zipFileName
        to: gsUpgraderCacheDirPath , '/caches/upgradeGLASS/metacelloPreview' ]