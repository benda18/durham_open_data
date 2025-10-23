library(renv)
library(readr)


snapshot()

rm(list=ls());cat('\f')

# https://live-durhamnc.opendata.arcgis.com/search

home.wd <- "C:/Users/bende/Documents/R/play/durham_open_data"
data.wd <- "C:/Users/bende/Documents/R/play/durham_open_data/data"

# rename crazy filenames
setwd(data.wd)
list.files()

base::file.rename(
  
)

addr <- readr::read_csv_chunked(file = "C:/Users/bende/Documents/R/play/durham_open_data/")

getwd()

list.files(path = "C:/Users/bende/Documents/R/play/durham_open_data/data")
