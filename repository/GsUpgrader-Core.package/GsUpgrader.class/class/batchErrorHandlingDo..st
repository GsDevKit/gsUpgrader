batch support
batchErrorHandlingDo: aBlock
  aBlock
    on: Error , Halt
    do: [ :ex | 
      Transcript
        cr;
        show: '========>Server Stack: ' , ex description printString;
        cr;
        show: (GsProcess stackReportToLevel: 500).
      Transcript
        cr;
        show: '========>Client Stack: ';
        cr.
      ex pass ]