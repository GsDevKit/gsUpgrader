upgrading
upgradeMetacello
  | metacello projectSpec |
  self loadMetacelloPreview.
  projectSpec := (Metacello image
    baseline: [ :spec | spec name = 'Metacello' ];
    list) first.
  projectSpec isLocked
    ifTrue: [ 
      projectSpec repositorySpecs
        detect: [ :repoSpec | repoSpec description = self metacelloRepositoryDescription ]
        ifNone: [ 
          self
            notify:
              'Metacello project repository is not in standard location ('
                , self metacelloRepositoryDescription
                , '). The upgrade of Metacello may not be complete.' ].
      metacello := Metacello image baseline: 'Metacello' ]
    ifFalse: [ 
      metacello := Metacello new
        baseline: 'Metacello';
        repository: self metacelloRepositoryDescription;
        yourself ].
  GsDeployer
    deploy: [ 
      self log: 'Upgrading Metacello'.
      metacello copy get.
      metacello copy load ]