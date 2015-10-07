private
logPackageReport: message
  | strm |
  strm := WriteStream on: String new.
  self packageReportOn: strm.
  Transcript
    cr;
    show: strm contents