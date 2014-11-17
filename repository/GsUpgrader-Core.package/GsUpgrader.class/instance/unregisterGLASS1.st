unregistering
unregisterGLASS1
  "unregister GLASS1"

  self unregisterGLASS.
  #('BaselineOfGLASS1')
    do: [ :className | 
      (self registrationFor: className)
        ifNotNil: [ :registration | registration unregisterProject ] ]