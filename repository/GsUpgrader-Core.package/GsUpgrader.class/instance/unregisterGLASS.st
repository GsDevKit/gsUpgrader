unregistering
unregisterGLASS
  "unregister GLASS, GsCore, GsMisc, GsMonticello and GsOB projects"

  self error: 'Do not use until public announcement'.
  #('ConfigurationOfGLASS' 'ConfigurationOfGsCore' 'ConfigurationOfGsMisc' 'ConfigurationOfGsMonticello' 'ConfigurationOfGsOB')
    do: [ :className | 
      (self registrationFor: className)
        ifNotNil: [ :registration | registration unregisterProject ] ]