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
              (self projectVersion: 'ConfigurationOfMetacello') versionNumber
                <= '1.0-beta.31.1' asMetacelloVersionNumber
                ifTrue: [ 
                  "load basic Metacello packages for version 1.0-beta.31.1. 
                   To load GLASS 1.0-beta.8.7.1:
	                  - Metacello must handle symbolic versions
	                  - MetacelloSkipDirtyPackageLoad needs to be defined"
                  self log: 'Bootstrapping Metacello1.0-beta.31.1'.
                  (Smalltalk at: #'Gofer') new
                    url: 'http://seaside.gemtalksystems.com/ss/metacello';
                    version: 'Metacello-Base-DaleHenrichs.19';
                    version: 'Metacello-Core-dkh.468';
                    version: 'Metacello-MC-dkh.531';
                    load.
                  (Smalltalk at: #'Gofer') new
                    url: 'http://seaside.gemtalksystems.com/ss/metacello';
                    version: 'Metacello-Platform.gemstone-dkh.23';
                    load ].
              [ 
              [ 
              Gofer new
                gemsource: 'MetacelloRepository';
                package: 'ConfigurationOfMetacello';
                package: 'ConfigurationOfGofer';
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
              ((Smalltalk at: #'ConfigurationOfGLASS') project
                version: '1.0-beta.9.2') load: #('Core' 'Monticello').
              ((Smalltalk at: #'ConfigurationOfGLASS') project
                version: '1.0-beta.9.2') load: #('Metacello').
              ((Smalltalk at: #'ConfigurationOfGLASS') project
                version: '1.0-beta.9.2') load ]
                on: (Smalltalk at: #'MetacelloSkipDirtyPackageLoad')
                do: [ :ex | ex resume: false ] ].
          ((Smalltalk at: #'ConfigurationOfGLASS') project
            version: '1.0-beta.9.3') load ] ]
    ifFalse: [ self log: 'GLASS already upgraded to 1.0-beta.9.3' ]