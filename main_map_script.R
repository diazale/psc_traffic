##########################################
# Check for/create directories as needed #
##########################################

# Check if the parent output directories needs to be created
if (file.exists(out_dir)){
  print(paste("Parent output directory already exists:", out_dir))
} else {
  dir.create(out_dir)
  print(paste("Created output directory:", out_dir))
}

# Directory for screenshots in general
if (file.exists(screenshot_output_dir)){
  print(paste("Screenshot directory already exists:", screenshot_output_dir))
} else {
  dir.create(screenshot_output_dir)
  print(paste("Created screenshot directory:", screenshot_output_dir))
}

# Directory for today's screenshots
# If needed, create a directory for today's output
if (file.exists(file.path(screenshot_output_dir, `dat_traffic`))){
  print(paste("Directory for today's screenshot already exists:", file.path(screenshot_output_dir, `dat_traffic`)))
} else {
  dir.create(file.path(screenshot_output_dir, `dat_traffic`))
  print(paste("Created today's screenshot directory:", file.path(screenshot_output_dir, `dat_traffic`)))
}

# Create the HTML directory if needed
if (file.exists(html_output_dir)){
  print(paste("HTML directory already exists:", html_output_dir))
} else {
  dir.create(html_output_dir)
  print(paste("Created HTML directory:", html_output_dir))
}


# Import traffic data for given lat/long
# Specify the size of the web page and zoom level
# Add traffic colours
# Store it in R object
traffic_map <- google_map(key = map_key, 
                          location = c(lat,lon),
                          width = w,
                          height = h,
                          zoom = z) %>%
  add_traffic()

# Save HTML file. This will be stored locally
saveWidget(traffic_map,
           paste0(html_output_dir, "/", dat_time, ".html"),
           selfcontained = FALSE)

# Take a screenshot as a PNG
webshot2::webshot(url = file.path(html_output_dir, paste0(dat_time, ".html")),
                  file = file.path(screenshot_output_dir, `dat_traffic`,
                                paste0(map_name, "_", dat_time,".png")),
                  vwidth = w,
                  vheight = h,
                  delay=d)