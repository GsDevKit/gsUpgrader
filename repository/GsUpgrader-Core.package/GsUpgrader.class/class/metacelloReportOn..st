analysis
metacelloReportOn: strm
  "produce a report listing the configurations, baselines and packages loaded in the image"

  self new
    projectReportOn: strm;
    packageReportOn: strm