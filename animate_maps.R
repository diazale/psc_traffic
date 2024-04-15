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




