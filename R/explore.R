renv::use(
  bit          = "bit@4.6.0",
  bit64        = "bit64@4.6.0-1",
  cli          = "cli@3.6.5",
  clipr        = "clipr@0.8.0",
  cpp11        = "cpp11@0.5.2",
  crayon       = "crayon@1.5.3",
  dplyr        = "dplyr@1.1.4",
  farver       = "farver@2.1.2",
  generics     = "generics@0.1.4",
  ggplot2      = "ggplot2@4.0.0",
  glue         = "glue@1.8.0",
  gtable       = "gtable@0.3.6",
  hms          = "hms@1.1.4",
  isoband      = "isoband@0.2.7",
  janitor      = "janitor@2.2.1",
  labeling     = "labeling@0.4.3",
  lifecycle    = "lifecycle@1.0.4",
  lubridate    = "lubridate@1.9.4",
  magrittr     = "magrittr@2.0.4",
  pillar       = "pillar@1.11.1",
  pkgconfig    = "pkgconfig@2.0.3",
  prettyunits  = "prettyunits@1.2.0",
  progress     = "progress@1.2.3",
  purrr        = "purrr@1.1.0",
  R6           = "R6@2.6.1",
  RColorBrewer = "RColorBrewer@1.1-3",
  readr        = "readr@2.1.5",
  renv         = "renv@1.1.5",
  rlang        = "rlang@1.1.6",
  S7           = "S7@0.2.0",
  scales       = "scales@1.4.0",
  snakecase    = "snakecase@0.11.1",
  stringi      = "stringi@1.8.7",
  stringr      = "stringr@1.5.2",
  tibble       = "tibble@3.3.0",
  tidyr        = "tidyr@1.3.1",
  tidyselect   = "tidyselect@1.2.1",
  timechange   = "timechange@0.3.0",
  tzdb         = "tzdb@0.5.0",
  utf8         = "utf8@1.2.6",
  vctrs        = "vctrs@0.6.5",
  viridisLite  = "viridisLite@0.4.2",
  vroom        = "vroom@1.6.6",
  withr        = "withr@3.0.2"
)

library(renv)
library(readr)
library(janitor)
library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(leaflet)

# embed()

snapshot()

rm(list=ls());cat('\f')

# https://live-durhamnc.opendata.arcgis.com/search

home.wd <- "C:/Users/bende/Documents/R/play/durham_open_data"
data.wd <- "C:/Users/bende/Documents/R/play/durham_open_data/data"

# rename and reformat address file----
setwd(data.wd)
list.files()
if(any(grepl(pattern = "^Active_Addresses_.{1,}\\.csv$", 
         x = list.files()))){
  file.rename(from = grep(pattern = "^Active_Addresses_.{1,}\\.csv$", 
                          x = list.files(), 
                          value = T), 
              to = "active_addresses.csv")
}

if(file.exists("active_addresses.csv")){
  addr <- read_csv("active_addresses.csv", n_max = Inf)
  addr <- select(addr, OBJECTID, 
                 #HOUSENUMSU, STREETDIR, STREETNAME, STREETTYPE, STDIRSUF, UNIT, CITY, CITY2,
                 SITE_ADDRE, USPS_ADDRESS, ZIPCODE,
                 ID, PARCEL_ID, PIN, 
                 SUBDIVISION, TYPE, IMPROVED, RES_TYPE,
                 # COMMENT, BLDG, PENDING, EDITDATE, CREATEDATE, RETIRE_DATE, OUTSIDE_COUNTY,
                 # MILEMARKER, 
                 x, y, GlobalID)
  saveRDS(object = addr, 
          file = "addr.Rds")
  file.remove("active_addresses.csv")
}

addr <- readRDS(file = "addr.RDS")
setwd(home.wd)


# Active Building Permits
setwd(data.wd)
list.files()
if(any(grepl(pattern = "^Active_Addresses_.{1,}\\.csv$", 
         x = list.files()))){
  file.rename(from = grep(pattern = "^Active_Addresses_.{1,}\\.csv$", 
                          x = list.files(), 
                          value = T), 
              to = "active_addresses.csv")
}

if(file.exists("Active_Building_Permits.csv")){
  abp  <- read_csv("Active_Building_Permits.csv", n_max = Inf)
  abp <- select(abp, 
                OBJECTID, Permit_ID, P_Activity, 
                P_Status, P_Type, 
                PID, PIN, 
                SiteAdd, Unit_Num, Unit_Type)
  saveRDS(object = abp, 
          file = "abp.Rds")
  file.remove("Active_Building_Permits.csv")
}

abp <- readRDS(file = "abp.RDS")
setwd(home.wd)

# crime----
setwd(data.wd)
list.files()
if(any(grepl(pattern = "^DPD_Crime.{1,}\\.csv$", 
             x = list.files()))){
  file.rename(from = grep(pattern = "^DPD_Crime_.{1,}\\.csv$", 
                          x = list.files(), 
                          value = T), 
              to = "DPD_Crime.csv")
}

if(file.exists("DPD_Crime.csv")){
  crime  <- read_csv("DPD_Crime.csv", n_max = Inf)
  
  saveRDS(object = crime, 
          file = "crime.Rds")
  file.remove("DPD_Crime.csv")
  setwd(home.wd)
}


crime <- readRDS(file = "crime.Rds")
abp   <- readRDS(file = "abp.Rds")
setwd(home.wd)

# explore building permits----
abp %>%
  group_by(P_Type,P_Status, P_Activity) %>%
  summarise(n_permits = n_distinct(Permit_ID), 
            n_pin = n_distinct(PIN), 
            n_pid = n_distinct(PID)) %>%
  .[order(.$n_permits,decreasing = T),] %>%
  as.data.table() %>%
  melt(., 
        id.vars = c("P_Type", "P_Status", "P_Activity") ) %>%
  as_tibble() %>%
  ggplot(data = .) + 
  geom_point(aes(x = P_Activity, y = value, color = variable))

unique(abp$P_Activity)


