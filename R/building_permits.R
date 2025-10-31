renv::use(
  askpass    = "askpass@1.2.1",
  cli        = "cli@3.6.5",
  curl       = "curl@7.0.0",
  dplyr      = "dplyr@1.1.4",
  generics   = "generics@0.1.4",
  glue       = "glue@1.8.0",
  lifecycle  = "lifecycle@1.0.4",
  magrittr   = "magrittr@2.0.4",
  pdftools   = "pdftools@3.6.0",
  pillar     = "pillar@1.11.1",
  pkgconfig  = "pkgconfig@2.0.3",
  qpdf       = "qpdf@1.4.1",
  R6         = "R6@2.6.1",
  Rcpp       = "Rcpp@1.1.0",
  renv       = "renv@1.1.5",
  rlang      = "rlang@1.1.6",
  sys        = "sys@3.4.3",
  tibble     = "tibble@3.3.0",
  tidyselect = "tidyselect@1.2.1",
  utf8       = "utf8@1.2.6",
  vctrs      = "vctrs@0.6.5",
  withr      = "withr@3.0.2"
)


# MONTHLY NEW RESIDENTAIL BUILDING PERMITS REPORTS: 

# county permit reports https://www.durhamnc.gov/Archive.aspx?AMID=51
# city   permit reports https://www.durhamnc.gov/Archive.aspx?AMID=45

library(dplyr)
library(renv)
library(pdftools)


rm(list=ls());cat('\f')
gc()

# snapshot()
