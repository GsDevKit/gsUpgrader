reporting
configurationVersionReportOn: strm
  "configuration versions"

  | count |
  count := 1.
  strm
    nextPutAll: '------------------------';
    cr;
    nextPutAll: 'Metacello Version REPORT';
    cr;
    nextPutAll: '------------------------';
    cr.
  ((Object allSubclasses
    select: [ :cl | 
      cl isMeta not
        and: [ cl isMetacelloConfig and: [ cl name asString beginsWith: 'ConfigurationOf' ] ] ])
    sort: [ :a :b | a name < b name ])
    collect: [ :each | 
      | cv |
      cv := each project currentVersion.
      cv ~~ nil
        ifTrue: [ 
          strm nextPutAll: count printString , '. '.
          strm
            nextPutAll:
                each name asString , '	' , cv versionNumber printString , '	'
                    , cv blessing printString;
            cr.
          count := count + 1 ] ]