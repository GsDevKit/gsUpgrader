private
upgradeGLASS: alternateConfigurationRepositoryDirectoryPathOrNil from: glassVersion
  "skip this step if GLASS1 is already loaded"

  self log: 'Upgrading GLASS to 1.0-beta.9.3'.
  self
    deploy: [ 
      | repository usingAlternate metacelloPreviewStableVersionString |
      repository := alternateConfigurationRepositoryDirectoryPathOrNil
        ifNotNil: [ 
          "Note that the alternate repository must have a copy of each of the 
           configurations listed in GsUpgrader>>refreshGLASSConfigurations:"
          usingAlternate := true.
          self
            log:
              'Using alternate repository: '
                , alternateConfigurationRepositoryDirectoryPathOrNil printString.
          MCDirectoryRepository new
            directory:
              (ServerFileDirectory on: alternateConfigurationRepositoryDirectoryPathOrNil) ]
        ifNil: [ 
          usingAlternate := false.
          repositoryOverride ~~ nil
            ifTrue: [ 
              self log: 'Using repositoryOverride: ' , repositoryOverride printString.
              repositoryOverride ]
            ifFalse: [ 
              self
                log:
                  'Using default repository: http://seaside.gemtalksystems.com/ss/MetacelloRepository'.
              MCHttpRepository
                location:
                  'http://seaside.gemtalksystems.com/ss/MetacelloRepository'
                user: ''
                password: '' ] ].
      Gofer new
        package: 'ConfigurationOfGLASS';
        repository: repository;
        load.
      glassVersion versionNumber < '1.0-beta.9.2' asMetacelloVersionNumber
        ifTrue: [ 
          self metacelloBootstrap10beta311Loaded
            ifFalse: [ self loadMetacelloBootstrap10beta311 ].
          [ 
          self refreshGLASSConfigurations: repository.
          ((Smalltalk at: #'ConfigurationOfMetacello') project
            version: #'previewBootstrap')
            repositoryOverrides: self repositoryOverrides;
            load.
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.2')
            repositoryOverrides: self repositoryOverrides;
            load: #('Core' 'Monticello').
          self patchForGsDevKitIssue60.	"re-apply patch"
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.2')
            repositoryOverrides: self repositoryOverrides;
            load ]
            on: (Smalltalk at: #'MetacelloSkipDirtyPackageLoad')
            do: [ :ex | ex resume: false ] ]
        ifFalse: [ 
          "explicitly load Metacello #previewBootstrap"
          usingAlternate
            ifTrue: [ 
              "refresh only needed if using alternate repo"
              self refreshGLASSConfigurations: repository ].
          (self
            goferBlockForUrl: 'http://seaside.gemtalksystems.com/ss/metacello')
            value
            package: 'ConfigurationOfMetacello';
            load.
          ((Smalltalk at: #'ConfigurationOfMetacello') project
            version: #'previewBootstrap')
            repositoryOverrides: self repositoryOverrides;
            load ].
      self upgradeGofer.
      (self goferBlockForUrl: 'http://seaside.gemtalksystems.com/ss/metacello')
        value
        package: 'ConfigurationOfMetacelloPreview';
        load.	" explicitly load ConfigurationOfMetacelloPreview"
      metacelloPreviewStableVersionString := ((Smalltalk
        at: #'ConfigurationOfMetacelloPreview') project version: #'stable')
        versionString.
      repositoryOverride
        ifNil: [ 
          ((Smalltalk at: #'ConfigurationOfGLASS') project version: '1.0-beta.9.3') load.
          gsUpgraderCacheDirPath
            ifNotNil: [ self ifNeededDownloadMetacelloPreviewFor: metacelloPreviewStableVersionString ] ]
        ifNotNil: [ 
          "Load MetacelloPreview separately -- repositoryOverrides does not apply to Metacello Preview"
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.3')
            repositoryOverrides: self repositoryOverrides;
            load:
                #('Core' 'Monticello' 'Metacello' 'Gofer' 'Release Support' 'OB' 'Metacello Tools' 'Gofer Project Loader').
          gsUpgraderCacheDirPath
            ifNil: [ 
              ((Smalltalk at: #'ConfigurationOfMetacelloPreview') project version: #'stable')
                load ]
            ifNotNil: [ 
              self ifNeededDownloadMetacelloPreviewFor: metacelloPreviewStableVersionString.
              (Smalltalk at: #'Metacello') new
                baseline: 'Metacello';
                repository:
                    'filetree://' , gsUpgraderCacheDirPath
                        ,
                          '/caches/upgradeGLASS/metacelloPreview/metacello-work-'
                        , metacelloPreviewStableVersionString , '/repository';
                load: 'batch' ] ].
      #('GsCore' 'GsMonticello' 'GsOB' 'GsMisc')
        do: [ :gsProjectName | 
          "Patch registrations with proper repository"
          self metacelloClass image
            configuration: gsProjectName;
            repository:
                'http://seaside.gemtalksystems.com/ss/MetacelloRepository';
            register ] ]