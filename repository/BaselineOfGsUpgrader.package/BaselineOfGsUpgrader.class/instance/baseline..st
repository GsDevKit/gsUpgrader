baseline
baseline: spec
  <baseline>
  spec
    for: #'common'
    do: [ 
      spec package: 'GsUpgrader-Core'.
      spec
        group: 'default' with: #('Core');
        group: 'Core' with: #('GsUpgrader-Core') ]