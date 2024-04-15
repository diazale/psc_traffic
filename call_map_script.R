#############
# Pre-amble #
#############

# API keys, library calls, etc.
source("zzz_map_key.R") # Map API key

# Import libraries
library(googleway)
library(htmlwidgets)
library(magick)
library(tidyverse)
library(webshot2)

##################
# Variable names #
##################

# Specify variable names, directories, map locations, etc

# Latitude and longitude where the maps API will be pointed
lat <- 41.822339
lon <- -71.4075898

# Map name (used for filenames)
map_name <- "south_water_st"

# HTML page details (how we want the web-page to appear)
w <- 1280 # width
h <- 980 # height
z <- 16 # zoom

delay <- 300 # delay in seconds between API calls

# Set up output directories
# Require three directories
# 1. Parent directory for output
# 2. HTML storage
# 3. Screenshot storage
# Default parent directory will be to current working directory
#out_dir <- getwd()
out_dir <- "G:/data/psc/south_water_st"

html_folder <- "html"
screenshot_folder <- "screenshots"
log_folder <- "logs"

html_output_dir <- file.path(out_dir, html_folder)
screenshot_output_dir <- file.path(out_dir, screenshot_folder)
log_dir <- file.path(out_dir, log_folder)

# Directory for logs
if (file.exists(log_dir)){
  print(paste("Log directory already exists:", log_dir))
} else {
  dir.create(log_dir)
  print(paste("Created log directory:", log_dir))
}

d <- 5 # Delay (in seconds) to allow web page elements to render

while(T){
  p1 <- Sys.time()

  # Current date
  # Used to store screenshots and logs by day
  dat_traffic <- Sys.Date()
  
  # Create/append to a logging file
  sink(file = file.path(log_dir, paste0(dat_traffic,"_log.txt")),
       type = c("output", "message"), append = TRUE)
  on.exit(sink()) # Release the file, or set it up for release on error/exit
  
  # Time stamp output as:
  # YYYY-MM-DD_hh-mm-ss
  dat_time <- format(Sys.time(), "%m-%d-%Y-%H_%M_%S")
  
  print(paste("Current dat_time:", dat_time))
  
  # Sometimes the API won't connect for some reason
  # Set up a try/catch to keep the loop going
  tryCatch(
    expr = {
      source("main_map_script.R")
      message("Successfully executed mapping script.")
    },
    error = function(e){
      message('ERROR!')
      print(e)
    },
    warning = function(w){
      message('WARNING!')
      print(w)
    }
  )
  
  source("main_map_script.R")
  sink()
  theDelay <- delay - as.numeric(difftime(Sys.time(),p1,unit="secs"))
  Sys.sleep(max(0, theDelay))
}
