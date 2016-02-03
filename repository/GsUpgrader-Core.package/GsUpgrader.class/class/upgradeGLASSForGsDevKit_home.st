projects
upgradeGLASSForGsDevKit_home
  "GsDevKit_home provides directories for caching mcz files needed during upgrade"

  | gemstoneVersion |
  gemstoneVersion := System stoneVersionReport at: 'gsVersion'.
  self _upgradeGLASSForGsDevKit_home: gemstoneVersion