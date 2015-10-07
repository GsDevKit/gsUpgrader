private
refreshGLASSConfigurations: repository
  [ 
  Gofer new
    repository: repository;
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
      ex resume ]