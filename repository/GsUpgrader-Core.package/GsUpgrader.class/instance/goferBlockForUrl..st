private
goferBlockForUrl: aRepoUrl
  ^ repositoryOverride
    ifNil: [ 
      [ 
      (Smalltalk at: #'Gofer') new
        url: aRepoUrl;
        yourself ] ]
    ifNotNil: [ 
      [ 
      (Smalltalk at: #'Gofer') new
        repository: repositoryOverride;
        yourself ] ]