reporting
packageReportOn: strm
  strm
    nextPutAll: '--------------';
    cr;
    nextPutAll: 'PACKAGE REPORT';
    cr;
    nextPutAll: '--------------';
    cr.
  (MCWorkingCopy allManagers
    sortWithBlock: [ :a :b | a packageName < b packageName ])
    do: [ :wc | 
      strm
        nextPutAll: wc ancestry ancestorString;
        cr ]