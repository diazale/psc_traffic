# Latitude and longitude where the maps API will be pointed
lat <- 41.822339
lon <- -71.4075898

# HTML page details (how we want the web-page to appear)
w <- 1280 # width
h <- 980 # height
z <- 16 # zoom

# Set up a directory to store the HTML files. Each file should take around 120kb of space (including folders)
html_folder <- "html"

# Create the HTML directory if needed
if (file.exists(paste0(getwd(), "/html"))){
  print("HTML directory already exists.")
} else {
  dir.create(paste0(getwd(), "/html"))
  print("HTML directory created.")
}

# Current date
# Used to store screenshots by day
dat_traffic <- Sys.Date()

# Check if the parent output directory needs to be created
if (file.exists(paste0(getwd(), "/output"))){
  print("Parent output directory already exists.")
} else {
  dir.create(paste0(getwd(), "/output"))
  print("Parent output directory created.")
}

# If needed, create a directory for today's output
if (file.exists(paste0(getwd(), "/output/", `dat_traffic`))){
  print("Directory for output already exists.")
} else {
  dir.create(paste0(getwd(), "/output/", `dat_traffic`))
  print("Directory for output has been created.")
}

# Time stamp output as:
# YYYY-MM-DD_hh-mm-ss
dat_time <- Sys.time() %>% 
  str_sub(start = 1) %>% 
  str_replace(pattern = ":",
              replacement = "-") %>% 
  str_replace(pattern = ":",
              replacement = "-") %>% 
  str_replace(pattern = " ",
              replacement = "_")

# Import traffic data for given lat/long
# Store it in R object
south_water_st_traffic <- google_map(key = map_key, 
           location = c(lat,
                        lon),
           width = w,
           height = h,
           zoom = z) %>%
  add_traffic()

# Save HTML file
saveWidget(south_water_st_traffic,
           paste0(html_folder, "/", dat_time, ".html"),
           selfcontained = FALSE)

#webshot("temp.html", 
#        vwidth = 1280,
#        vheight = 980,
#        file = paste0(`dat_traffic`, "/",
#                      "south_water_st ", dat_time,
#                      ".png"),
#        cliprect = "viewport",
#        delay = 10)

webshot2::webshot(url = paste0(html_folder, "/", dat_time, ".html"),
                  file = paste0("output/",
                                `dat_traffic`, "/",
                                "south_water_st ", dat_time,".png"),
                  vwidth = 1280,
                  vheight = 980,
                  delay=5)
