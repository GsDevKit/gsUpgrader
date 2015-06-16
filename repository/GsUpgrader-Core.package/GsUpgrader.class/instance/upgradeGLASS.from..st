private
upgradeGLASS: configurationDirectoryOrNil from: glassVersion
  "skip this step if GLASS1 is already loaded"

  self log: 'Upgrading GLASS to 1.0-beta.9.3'.
  self
    deploy: [ 
      | repository |
      repository := configurationDirectoryOrNil
        ifNotNil: [ 
          MCDirectoryRepository new
            directory: (ServerFileDirectory on: configurationDirectoryOrNil) ]
        ifNil: [ 
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
          [ 
          Gofer new
            repository: repository;
            package: 'ConfigurationOfGofer';
            package: 'ConfigurationOfMetacello';
            package: 'ConfigurationOfGsCore';
            package: 'ConfigurationOfGoferProjectLoader';
            package: 'ConfigurationOfGsMonticello';
            package: 'ConfigurationOfGsOB';
            package: 'ConfigurationOfGsMisc';
            package: 'ConfigurationOfGsSqueakCommon';
            load ]
            on: Warning
            do: [ :ex | 
              self log: ex description.
              ex resume ].
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