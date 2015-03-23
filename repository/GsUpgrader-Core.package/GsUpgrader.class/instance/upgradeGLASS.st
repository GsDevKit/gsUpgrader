upgrading
upgradeGLASS
  "skip this step if GLASS1 is already loaded"

  | glassVersion originalVersion |
  self glass1Loaded
    ifTrue: [ 
      self inform: 'GLASS1 is loaded. Skipping GLASS upgrade.'.
      ^ self ].
  self metacelloPreviewLoaded
    ifTrue: [ 
      self inform: 'MetacelloPreview is loaded. Skipping GLASS upgrade.'.
      ^ self ].
  glassVersion := self projectVersion: 'ConfigurationOfGLASS'.
  self patchForGsDevKitIssue60.
  glassVersion versionNumber < '1.0-beta.9.3' asMetacelloVersionNumber
    ifTrue: [ 
      self log: 'Upgrading GLASS to 1.0-beta.9.3'.
      self
        deploy: [ 
          Gofer new
            package: 'ConfigurationOfGLASS';
            url: 'http://seaside.gemtalksystems.com/ss/MetacelloRepository';
            load.
          glassVersion versionNumber < '1.0-beta.9.2' asMetacelloVersionNumber
            ifTrue: [ 
              self metacelloBootstrap10beta311Loaded
                ifFalse: [ self loadMetacelloBootstrap10beta311 ].
              [ 
              [ 
              Gofer new
                url: 'http://seaside.gemtalksystems.com/ss/MetacelloRepository';
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
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.3') load.
          #('GsCore' 'GsMonticello' 'GsOB' 'GsMisc')
            do: [ :gsProjectName | 
              "Patch registrations with proper repository"
              self metacelloClass image
                configuration: gsProjectName;
                repository:
                    'http://seaside.gemtalksystems.com/ss/MetacelloRepository';
                register ] ] ]
    ifFalse: [ self log: 'GLASS already upgraded to 1.0-beta.9.3' ]