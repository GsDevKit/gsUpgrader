unregistering
unregisterGLASS1
  "unregister GLASS1"

  self error: 'Do not use until public announcement'.
  self unregisterGLASS.
  #('BaselineOfGLASS1')
    do: [ :className | 
      (self registrationFor: className)
        ifNotNil: [ :registration | registration unregisterProject ] ]