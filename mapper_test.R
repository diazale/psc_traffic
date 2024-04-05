# Import API key. Kept in a separate file for security.
source("map_key.R")

# Import libraries
library(googleway)
library(htmlwidgets)
library(magick)
library(tidyverse)
library(webshot)

# Today's date
dat_traffic <- Sys.Date()

# Create directories if needed
if (file.exists(paste0(getwd(), "/", `dat_traffic`))){
  print("Directory already exists")
} else {
  dir.create(paste0(getwd(), "/", `dat_traffic`))
  print("Directory has now been Created")
}

# Time stamp, reformatted as "MM-DD_hh-mm-ss"
dat_time <- Sys.time() %>% 
  ## Format on my local machine is: "2020-04-01 20:21:30"
  str_sub(start = 6) %>% 
  str_replace(pattern = ":",
              replacement = "-") %>% 
  str_replace(pattern = ":",
              replacement = "-") %>% 
  str_replace(pattern = " ",
              replacement = "_")

# Import traffic data for given long/lat
south_water_st_traffic <- google_map(key = map_key, 
           location = c(41.8234955,
                        -71.40323,16.35),
           width = 1280,
           height = 980,
           zoom = 16) %>%
  add_traffic()

# Save to HTML file
saveWidget(south_water_st_traffic,
           "temp.html",
           selfcontained = FALSE)
webshot("temp.html", 
        vwidth = 1280,
        vheight = 980,
        file = paste0(`dat_traffic`, "/",
                      "south_water_st ", dat_time,
                      ".png"),
        cliprect = "viewport",
        delay = 4)
