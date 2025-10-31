renv::use(
  askpass           = "askpass@1.2.1",
  base64enc         = "base64enc@0.1-3",
  bit               = "bit@4.6.0",
  bit64             = "bit64@4.6.0-1",
  bslib             = "bslib@0.9.0",
  cachem            = "cachem@1.1.0",
  class             = "class@7.3-23",
  classInt          = "classInt@0.4-11",
  cli               = "cli@3.6.5",
  clipr             = "clipr@0.8.0",
  cpp11             = "cpp11@0.5.2",
  crayon            = "crayon@1.5.3",
  crosstalk         = "crosstalk@1.2.2",
  curl              = "curl@7.0.0",
  data.table        = "data.table@1.17.8",
  DBI               = "DBI@1.2.3",
  digest            = "digest@0.6.37",
  dplyr             = "dplyr@1.1.4",
  e1071             = "e1071@1.7-16",
  evaluate          = "evaluate@1.0.5",
  farver            = "farver@2.1.2",
  fastmap           = "fastmap@1.2.0",
  fontawesome       = "fontawesome@0.5.3",
  fs                = "fs@1.6.6",
  generics          = "generics@0.1.4",
  ggplot2           = "ggplot2@4.0.0",
  glue              = "glue@1.8.0",
  gtable            = "gtable@0.3.6",
  highr             = "highr@0.11",
  hms               = "hms@1.1.4",
  htmltools         = "htmltools@0.5.8.1",
  htmlwidgets       = "htmlwidgets@1.6.4",
  httr              = "httr@1.4.7",
  isoband           = "isoband@0.2.7",
  janitor           = "janitor@2.2.1",
  jquerylib         = "jquerylib@0.1.4",
  jsonlite          = "jsonlite@2.0.0",
  KernSmooth        = "KernSmooth@2.23-26",
  knitr             = "knitr@1.50",
  labeling          = "labeling@0.4.3",
  lattice           = "lattice@0.22-7",
  lazyeval          = "lazyeval@0.2.2",
  leaflet           = "leaflet@2.2.3",
  leaflet.providers = "leaflet.providers@2.0.0",
  lifecycle         = "lifecycle@1.0.4",
  lubridate         = "lubridate@1.9.4",
  magrittr          = "magrittr@2.0.4",
  MASS              = "MASS@7.3-65",
  memoise           = "memoise@2.0.1",
  mime              = "mime@0.13",
  openssl           = "openssl@2.3.4",
  pillar            = "pillar@1.11.1",
  pkgconfig         = "pkgconfig@2.0.3",
  png               = "png@0.1-8",
  prettyunits       = "prettyunits@1.2.0",
  progress          = "progress@1.2.3",
  proxy             = "proxy@0.4-27",
  purrr             = "purrr@1.1.0",
  R6                = "R6@2.6.1",
  rappdirs          = "rappdirs@0.3.3",
  raster            = "raster@3.6-32",
  RColorBrewer      = "RColorBrewer@1.1-3",
  Rcpp              = "Rcpp@1.1.0",
  readr             = "readr@2.1.5",
  renv              = "renv@1.1.5",
  rlang             = "rlang@1.1.6",
  rmarkdown         = "rmarkdown@2.30",
  rvest             = "rvest@1.0.5",
  s2                = "s2@1.1.9",
  S7                = "S7@0.2.0",
  sass              = "sass@0.4.10",
  scales            = "scales@1.4.0",
  selectr           = "selectr@0.4-2",
  sf                = "sf@1.0-21",
  snakecase         = "snakecase@0.11.1",
  sp                = "sp@2.2-0",
  stringi           = "stringi@1.8.7",
  stringr           = "stringr@1.5.2",
  sys               = "sys@3.4.3",
  terra             = "terra@1.8-70",
  tibble            = "tibble@3.3.0",
  tidycensus        = "tidycensus@1.7.3",
  tidyr             = "tidyr@1.3.1",
  tidyselect        = "tidyselect@1.2.1",
  tigris            = "tigris@2.2.1",
  timechange        = "timechange@0.3.0",
  tinytex           = "tinytex@0.57",
  tzdb              = "tzdb@0.5.0",
  units             = "units@1.0-0",
  utf8              = "utf8@1.2.6",
  uuid              = "uuid@1.2-1",
  vctrs             = "vctrs@0.6.5",
  viridisLite       = "viridisLite@0.4.2",
  vroom             = "vroom@1.6.6",
  withr             = "withr@3.0.2",
  wk                = "wk@0.9.4",
  xfun              = "xfun@0.53",
  xml2              = "xml2@1.4.1",
  yaml              = "yaml@2.3.10"
)

library(renv)
library(readr)
library(janitor)
library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(leaflet)
library(tidycensus)

# embed()

snapshot()


rm(list=ls()[!ls() %in% c("vars23")]);cat('\f');gc()

# https://live-durhamnc.opendata.arcgis.com/search

home.wd <- "C:/Users/bende/Documents/R/play/durham_open_data"
data.wd <- "C:/Users/bende/Documents/R/play/durham_open_data/data"

# rename and reformat address file----
setwd(data.wd)
list.files()


rents_co <- read_csv(file = grep("^County_zori", list.files(), value = T))
colnames(rents_co)

rents_co.melt <- melt(as.data.table(rents_co),
                      id.vars = c("RegionID", "SizeRank", "RegionName", "RegionType", 
                                  "StateName", "State", "Metro", "StateCodeFIPS", 
                                  "MunicipalCodeFIPS"), 
                      variable.name = "date", 
                      value.name = "monthly_rent")

rents_co.melt <- as.data.frame(rents_co.melt) %>%
  as_tibble()%>%
  mutate(date = ymd(date))

rents_co.melt %>%
  filter(State == "NC") %>%
  .[grepl("Wake|Durham|Orange|Mecklenburg", .$RegionName),] %>%
  mutate(year = year(date), 
         month = lubridate::month(date)) %>%
  select(RegionID, RegionName, State, Metro, date, year, month, monthly_rent) %>%
  ggplot(data = ., 
         aes(x = date, y = monthly_rent, color = RegionName)) +
  geom_line()

rents_co.melt %>%
  filter(State == "NC") %>%
  mutate(year = year(date)) %>%
  group_by(Metro, year) %>%
  summarise(avg_rent = mean(monthly_rent, na.rm = T), 
            n = n()) %>%
  ggplot(data =., 
         aes(x = year, y = avg_rent, color = Metro)) +
  geom_line()


# population per dwelling unit or bedroom or something

# all variables
if(!"vars23" %in% ls()){
  vars23 <- tidycensus::load_variables(year=2023, 
                                       dataset = "acs5")
}
vars23

vars23$concept %>% unique() %>%
  grep(patter = "unit", x = ., ignore.case = T, value = T) %>%
  .[!grepl("by tenure|mobility|place of birth", ., ignore.case = T)]

vars23$concept %>% unique() %>%
  grep(patter = "unit|bedroom|household size|occupied", x = ., ignore.case = T, value = T)

vars23$concept %>% unique() %>%
  grep(patter = "total population", x = ., ignore.case = T, value = T)
vars23$concept %>% unique() %>%
  grep(patter = "housing units", x = ., ignore.case = T, value = T)
vars23$concept %>% unique() %>%
  grep(patter = "costs", x = ., ignore.case = T, value = T)
# vars23$concept %>% unique() %>%
#   grep(patter = "insurance", x = ., ignore.case = T, value = T)

cw_temp <- vars23[vars23$concept %in% 
         c("Housing Units", "Total Population", 
           "Housing Costs as a Percentage of Household Income in the Past 12 Months"),] %>%
  select(name, label, concept, geography) %>%
  .[grepl("Estimate!!Total$|Estimate!!Total:$", 
          x = .$label, ignore.case = T),] %>%
  select(name, label, concept)


temp_data <- tidycensus::get_acs(geography = "block group", 
                    variables = c("B01003_001", 
                                  "B25001_001", 
                                  "B25140_001"), 
                    state = "NC", 
                    county = c("Durham"), 
                    geometry = F, 
                    year = 2023)

cw_temp

left_join(temp_data, 
          cw_temp, by = c("variable" = "name")) %>%
  janitor::clean_names() %>%
  select(geoid, 
         #name,
         #label,
         concept, 
         #variable, 
         estimate) %>%
  mutate(year = 2023) 

# otherstuff----

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

abp$Unit_Num %>% table()

abp %>%
  janitor::clean_names() %>%
  group_by(p_activity#, p_status
           ) %>%
  summarise(#n_parcels = n_distinct(pid), 
            n_permits = n_distinct(permit_id)) %>%
  as.data.table() %>%
  #dcast(., p_activity ~ p_status, fill = 0) %>%
  #.[order(.$ISS, decreasing = T),]
  as_tibble() %>%
  .[order(.$n_permits,decreasing = T),]

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
  crime <- select(crime, 
                  OBJECTID, INCI_ID, DATE_REPT, HOUR_REPT, REPORTEDAS, 
                  UCR_CODE, CHRGDESC, 
                  ATTM_COMP, 
                  PREMISE, WEAPON, CSSTATUS, 
                  DIST, BEAT) 
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

# explore crime----

crime


crime %>%
  group_by(BEAT) %>%
  summarise(n=n()) %>%
  ggplot(data = ., 
         aes(x = n)) + 
  geom_density()

crime %>%
  ggplot(data = ., aes(x = BEAT, y = CHRGDESC)) + 
  geom_jitter()

crime$REPORTEDAS %>% 
  unique() %>%
  length()
crime$CHRGDESC %>%
  unique() %>%
  length()


