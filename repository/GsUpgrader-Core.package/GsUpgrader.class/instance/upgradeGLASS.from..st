private
upgradeGLASS: alternateConfigurationRepositoryDirectoryPathOrNil from: glassVersion
  "skip this step if GLASS1 is already loaded"

  self log: 'Upgrading GLASS to 1.0-beta.9.3'.
  self
    deploy: [ 
      | repository usingAlternate |
      repository := alternateConfigurationRepositoryDirectoryPathOrNil
        ifNotNil: [ 
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
          self
            log:
              'Using default repository: http://seaside.gemtalksystems.com/ss/MetacelloRepository'.
          MCHttpRepository
            location: 'http://seaside.gemtalksystems.com/ss/MetacelloRepository'
            user: ''
            password: '' ].
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
            version: #'previewBootstrap') load.
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.2') load: #('Core' 'Monticello').
          self patchForGsDevKitIssue60.	"re-apply patch"
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.2') load ]
            on: (Smalltalk at: #'MetacelloSkipDirtyPackageLoad')
            do: [ :ex | ex resume: false ] ]
        ifFalse: [ 
          "explicitly load Metacello #previewBootstrap"
          usingAlternate
            ifTrue: [ 
              "refresh only needed if using alternate repo"
              self refreshGLASSConfigurations: repository ].
          Gofer new
            url: 'http://seaside.gemtalksystems.com/ss/metacello';
            package: 'ConfigurationOfMetacello';
            load.
          ((Smalltalk at: #'ConfigurationOfMetacello') project
            version: #'previewBootstrap') load ].
      self upgradeGofer.
      ((Smalltalk at: #'ConfigurationOfGLASS') project version: '1.0-beta.9.3')
        load.
      #('GsCore' 'GsMonticello' 'GsOB' 'GsMisc')
        do: [ :gsProjectName | 
          "Patch registrations with proper repository"
          self metacelloClass image
            configuration: gsProjectName;
            repository:
                'http://seaside.gemtalksystems.com/ss/MetacelloRepository';
            register ] ]