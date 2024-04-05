# Import API key. Kept in a separate file for security.
source("zzz_map_key.R")

# Import libraries
library(googleway)
library(htmlwidgets)
library(magick)
library(tidyverse)
library(webshot2)

p1 <- Sys.time()
source("mapper_test.R")
theDelay <- 600-as.numeric(difftime(Sys.time(),p1,unit="secs"))
Sys.sleep(max(0, theDelay)