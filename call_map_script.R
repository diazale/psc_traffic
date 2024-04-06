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

html_output_dir <- file.path(out_dir, html_folder)
screenshot_output_dir <- file.path(out_dir, screenshot_folder)

d <- 5 # Delay (in seconds) to allow web page elements to render

# Current date
# Used to store screenshots by day
dat_traffic <- Sys.Date()

# Time stamp output as:
# YYYY-MM-DD_hh-mm-ss
dat_time <- format(Sys.time(), "%m-%d-%Y-%H_%M_%S")

source("main_map_script.R")