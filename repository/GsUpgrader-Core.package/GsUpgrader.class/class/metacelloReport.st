analysis
metacelloReport
  "produce a report listing the configurations, baselines and packages loaded in the image"

  | strm |
  strm := WriteStream on: String new.
  self metacelloReportOn: strm.
  ^ strm contents