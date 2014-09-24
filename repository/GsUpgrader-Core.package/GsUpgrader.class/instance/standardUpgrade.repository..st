private
standardUpgrade: projectName repository: repositoryDescription
  | specs projectSpec metacello |
  specs := self metacelloClass image
    baseline: [ :spec | spec name = projectName ];
    list.
  specs isEmpty
    ifFalse: [ projectSpec := specs first ].
  (projectSpec notNil and: [ projectSpec isLocked ])
    ifTrue: [ 
      projectSpec repositorySpecs
        detect: [ :repoSpec | repoSpec description = repositoryDescription ]
        ifNone: [ 
          self
            notify:
              projectName , ' project repository is not in standard location ('
                , self metacelloRepositoryDescription , '). The upgrade of '
                , projectName , ' may not be complete.' ].
      metacello := self metacelloClass image baseline: projectName ]
    ifFalse: [ 
      metacello := self metacelloClass new
        baseline: projectName;
        repository: repositoryDescription;
        yourself ].
  self
    deploy: [ 
      self log: 'Upgrading ' , projectName.
      metacello copy get.
      metacello copy load ]