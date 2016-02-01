private
ifNeededDownloadMetacelloPreviewFor: metacelloPreviewStableVersionString
  | path zipUrl pid zipFileName sel |
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
  sel := (MetacelloPlatform current respondsTo: #'downloadFile:to:')
    ifTrue: [ 
      "older versions of Metacello in base image of older versions of GemStone"
      #'downloadFile:to:' ]
    ifFalse: [ #'downloadBasicFile:to:' ].
  MetacelloPlatform current
    perform: sel
    with:
      {zipUrl.
      zipFileName}.	"avoid sentButNotImplemented test errors"
  MetacelloPlatform current
    extractRepositoryFrom: zipFileName
    to: gsUpgraderCacheDirPath , '/caches/upgradeGLASS/metacelloPreview'