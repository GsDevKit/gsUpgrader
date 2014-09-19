loading
loadMetacelloBootstrap10beta311
  "load basic Metacello packages for version 1.0-beta.31.1. 
   To load GLASS 1.0-beta.8.7.1:
     - Metacello must handle symbolic versions
	  - MetacelloSkipDirtyPackageLoad needs to be defined"

  (self projectVersion: 'ConfigurationOfMetacello') versionNumber
    > '1.0-beta.31.1' asMetacelloVersionNumber
    ifTrue: [ ^ self ].
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
    load