reporting
projectReportOn: strm
  "Use registraion and get configuration/baseline versions otherwise get configuration versions"

  self metacelloPreviewLoaded
    ifTrue: [ self metacelloRegistrationReportOn: strm ]
    ifFalse: [ self configurationVersionReportOn: strm ]