unregistering
unregisterGLASS
  "unregister GLASS, GsCore, GsMisc, GsMonticello and GsOB projects"

  #('ConfigurationOfGLASS' 'ConfigurationOfGsCore' 'ConfigurationOfGsMisc' 'ConfigurationOfGsMonticello' 'ConfigurationOfGsOB')
    do: [ :className | 
      (self registrationFor: className)
        ifNotNil: [ :registration | registration unregisterProject ] ]