library(lubridate)
library(magick)
library(stringr)

# Set up directories using outside script
source("set_dirs.R")

anno <- function(sc){
  temp_date_time_str <- tools::file_path_sans_ext(strsplit(sc,"south_water_st_")[[1]][2])
  temp_date_time <- parse_date_time(temp_date_time_str, orders = "%m-%d-%y-%H_%M_%S")
  
  i <- image_read(sc)
  
  date_time_str <- paste0(
    wday(temp_date_time, label=T), " ",
    month(temp_date_time, label=T), " ",
    day(temp_date_time), ", ",
    year(temp_date_time), ", ",
    format(temp_date_time, "%H:%M")
  )
  
  i <- image_annotate(i, date_time_str,
                      location = "+0+0",
                      gravity = "northeast",
                      size = 50)
}

imgs <- list.files(screenshot_dir, full.names = TRUE)
img_list <- lapply(imgs, FUN=anno)
img_joined <- image_join(img_list)
img_animated <- image_animate(img_joined, fps = 2, optimize = TRUE)
image_write(img_animated, file.path(animations_dir, "test.gif"))

# Animate other days
# File format
# G:\data\psc\south_water_st\screenshots\2024-04-09
# south_water_st_04-09-2024-08_50_42.png
# Filter by days and hours

imgs <- list.files(screenshot_dir_day, full.names = TRUE)

#tail(strsplit(imgs[1], "/")[[1]], 1)

# DD
#substr(tail(strsplit(imgs[1], "/")[[1]], 1),19,20)

# HH
#substr(tail(strsplit(imgs[1], "/")[[1]], 1),27,28)

start_day <- 09
end_day <- 09

start_hour <- 12
end_hour <- 19

for (start_day in 8:8){
  
  end_day <- start_day

  screenshot_dir_day <- file.path(screenshot_dir, paste0("2024-04-",
                                                         as.character(sprintf("%002d", start_day))))
  imgs <- list.files(screenshot_dir_day, full.names = TRUE)
  
  # images filtered for time/day
  imgs_filtered <- c()
  
  for (i in imgs){
    fname <- tools::file_path_sans_ext(basename(i))
    
    dd <- substr(fname,19,20)
    hh <- substr(fname,27,28)
    
    if (start_day <= as.numeric(dd) &&
        as.numeric(dd) <= end_day &&
        start_hour <= as.numeric(hh) &&
        as.numeric(hh) <= end_hour){
      #print("yes")
      imgs_filtered <- c(imgs_filtered, i)
    } else {
      #print("no")
    }
    
    #print(tail(strsplit(i,"/")[[1]], 1))
  }
  
  img_list <- lapply(imgs_filtered, FUN=anno)
  img_joined <- image_join(img_list)
  img_animated <- image_animate(img_joined, fps = 2, optimize = TRUE)
  
  image_write(img_animated, file.path(animations_dir, paste0("south_water_st_",
                                                             sprintf("%002d", start_day),
                                                             ".gif")))
}






