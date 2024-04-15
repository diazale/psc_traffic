# Parse the police report OCR strings

fdir <- "police_reports/ocr"

##### Parse narrative 20240326125551864 #####
fname <- "20240326125551864.txt"

ocr_text <- scan(file.path(fdir, fname), character() )

test <- strsplit(ocr_text, "Supplemental")

# Test to see which keywords work
# Check for keywords
kw <- "Narrative/Diagram Supplemental"
kw_start <- "Diagram Supplemental\n"
kw_end <- "Page"

counter <- 0
counter_start <- 0
counter_end <- 0

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    counter <- counter + 1
    
    if(grepl(kw_start, o, fixed = TRUE)==TRUE){
      counter_start <- counter_start + 1
    }
    
    if(grepl(kw_end, o, fixed = TRUE)==TRUE){
      counter_end <- counter_end + 1
    } else if (grepl(kw_start, o, fixed = TRUE)==TRUE){
      # Cases where we have the starting string but not the ending string
      print(o)
    }
    #print(o)
  }
}

# Looks like these keys work...
# Parse the OCR and extract the supplementals and the IDs
# ID should be immediately before "Narrative/Diagram Supplemental"
# Looks like the format for this file is YYYY-NNNNNNNN Narrative/Diagram Supplemental

# Strategy: Grab the text between "Diagram Supplemental\n" and "Page"
# Grab the 13 characters before "Narrative/Diagram Supplemental"
# These will give values and IDs
id_vec <- c()
narrative_vec <- c()

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    
    # Extract the narrative text
    temp_str <- strsplit(o, kw_start, fixed = TRUE)
    temp_str <- strsplit(temp_str[[1]][2], kw_end, fixed = TRUE)
    temp_str <- trimws(temp_str[[1]][1])
    
    # Add to the narrative text vector
    narrative_vec <- c(narrative_vec, temp_str)
    
    # Get the ID
    temp_str <- strsplit(o, " Narrative/Diagram Supplemental", fixed = TRUE)
    temp_str <- substr(temp_str[[1]][1], nchar(temp_str[[1]][1])-12, nchar(temp_str[[1]][1]))
    
    id_vec <- c(id_vec, temp_str)
    
    #print(o)
  }
}

# Put into a data frame to then export
temp <- data.frame(list(id_vec, narrative_vec))
colnames(temp) <- c("Full_ID","Narrative")
temp["Year"] <- lapply(temp["Full_ID"], FUN=function(x) substr(x, 1,4))
temp["Crash_ID"] <- lapply(temp["Full_ID"], FUN=function(x) substr(x, 6,13))

out_path <- file.path("police_reports/ocr/extracted",
                      paste0(strsplit(fname,".txt")[[1]][1], "_narratives"))

# Output text file
#write.table(temp, paste0(out_path, ".txt"), row.names = FALSE)

# Output excel file
#writexl::write_xlsx(temp, paste0(out_path, ".xlsx"))

##### Parse narrative 20240326125838933 ######

fname <- "20240326125838933.txt"

ocr_text <- scan(file.path(fdir, fname), character() )

test <- strsplit(ocr_text, "Supplemental")

# Test to see which keywords work
# Check for keywords
kw <- "Narrative/Diagram Supplemental"
kw_start <- "Diagram Supplemental\n"
kw_end <- "Page"

counter <- 0
counter_start <- 0
counter_end <- 0

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    counter <- counter + 1
    
    if(grepl(kw_start, o, fixed = TRUE)==TRUE){
      counter_start <- counter_start + 1
    }
    
    if(grepl(kw_end, o, fixed = TRUE)==TRUE){
      counter_end <- counter_end + 1
    } else if (grepl(kw_start, o, fixed = TRUE)==TRUE){
      # Cases where we have the starting string but not the ending string
      print(o)
    }
  }
}

id_vec <- c()
narrative_vec <- c()

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    
    # Extract the narrative text
    temp_str <- strsplit(o, kw_start, fixed = TRUE)
    temp_str <- strsplit(temp_str[[1]][2], kw_end, fixed = TRUE)
    temp_str <- trimws(temp_str[[1]][1])
    
    # Add to the narrative text vector
    narrative_vec <- c(narrative_vec, temp_str)
    
    # Get the ID
    temp_str <- strsplit(o, " Narrative/Diagram Supplemental", fixed = TRUE)
    temp_str <- substr(temp_str[[1]][1], nchar(temp_str[[1]][1])-12, nchar(temp_str[[1]][1]))
    
    id_vec <- c(id_vec, temp_str)
    
    #print(o)
  }
}

# Put into a data frame to then export
temp <- data.frame(list(id_vec, narrative_vec))
colnames(temp) <- c("Full_ID","Narrative")
temp["Year"] <- lapply(temp["Full_ID"], FUN=function(x) substr(x, 1,4))
temp["Crash_ID"] <- lapply(temp["Full_ID"], FUN=function(x) substr(x, 6,13))

out_path <- file.path("police_reports/ocr/extracted",
                      paste0(strsplit(fname,".txt")[[1]][1], "_narratives"))

# Output text file
#write.table(temp, paste0(out_path, ".txt"), row.names = FALSE)

# Output excel file
#writexl::write_xlsx(temp, paste0(out_path, ".xlsx"))

#### Parse narrative 20240326130157142 ####

fname <- "20240326130157142.txt"

ocr_text <- scan(file.path(fdir, fname), character() )

test <- strsplit(ocr_text, "Supplemental")

# Test to see which keywords work
# Check for keywords
kw <- "Narrative/Diagram Supplemental"
kw_start <- "Diagram Supplemental\n"
kw_end <- "Page"

counter <- 0
counter_start <- 0
counter_end <- 0

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    counter <- counter + 1
    
    if(grepl(kw_start, o, fixed = TRUE)==TRUE){
      counter_start <- counter_start + 1
    }
    
    if(grepl(kw_end, o, fixed = TRUE)==TRUE){
      counter_end <- counter_end + 1
    } else if (grepl(kw_start, o, fixed = TRUE)==TRUE){
      # Cases where we have the starting string but not the ending string
      print(o)
    }
  }
}

id_vec <- c()
narrative_vec <- c()

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    
    # Extract the narrative text
    temp_str <- strsplit(o, kw_start, fixed = TRUE)
    temp_str <- strsplit(temp_str[[1]][2], kw_end, fixed = TRUE)
    temp_str <- trimws(temp_str[[1]][1])
    
    # Add to the narrative text vector
    narrative_vec <- c(narrative_vec, temp_str)
    
    # Get the ID
    temp_str <- strsplit(o, " Narrative/Diagram Supplemental", fixed = TRUE)
    temp_str <- substr(temp_str[[1]][1], nchar(temp_str[[1]][1])-12, nchar(temp_str[[1]][1]))
    
    id_vec <- c(id_vec, temp_str)
    
    #print(o)
  }
}

# Put into a data frame to then export
temp <- data.frame(list(id_vec, narrative_vec))
colnames(temp) <- c("Full_ID","Narrative")
temp["Year"] <- lapply(temp["Full_ID"], FUN=function(x) substr(x, 1,4))
temp["Crash_ID"] <- lapply(temp["Full_ID"], FUN=function(x) substr(x, 6,13))

out_path <- file.path("police_reports/ocr/extracted",
                      paste0(strsplit(fname,".txt")[[1]][1], "_narratives"))

# Output text file
#write.table(temp, paste0(out_path, ".txt"), row.names = FALSE)

# Output excel file
#writexl::write_xlsx(temp, paste0(out_path, ".xlsx"))

##### Parse make/model #####
# Look for keyword "Plate Type" and take the next line
# "Plate Type" is the last string to appear before the vehicle's Make/Model (in some cases, anyway)

fname <- "20240326130157142.txt"
#fname <- "20240326125838933.txt"
#fname <- "20240326130157142.txt"

ocr_text <- scan(file.path(fdir, fname), character() )


kw <- "Plate Type"
kw_start <- "Plate Type\n"
kw_end <- "\n"

counter <- 0
counter_start <- 0
counter_end <- 0

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    counter <- counter + 1
    
    if(grepl(kw_start, o, fixed = TRUE)==TRUE){
      counter_start <- counter_start + 1
    }
    
    if(grepl(kw_end, o, fixed = TRUE)==TRUE){
      counter_end <- counter_end + 1
    } else if (grepl(kw_start, o, fixed = TRUE)==TRUE){
      # Cases where we have the starting string but not the ending string
      print(o)
    }
  }
}

id_vec <- c()
vehicle_vec <- c()

for (o in ocr_text){
  if(grepl(kw, o, fixed = TRUE)==TRUE){
    
    # Extract the narrative text
    temp_str <- strsplit(o, kw_start, fixed = TRUE)
    temp_str <- strsplit(temp_str[[1]][2], kw_end, fixed = TRUE)
    temp_str <- trimws(temp_str[[1]][1])
    
    # Add to the narrative text vector
    vehicle_vec <- c(vehicle_vec, temp_str)
    
    # Get the ID
    
    temp_str <- strsplit(o, "Parking Lot\nProvidence 2", fixed = TRUE)
    #print(temp_str[[1]][2])
    temp_str <- substr(temp_str[[1]][2], 1, 13)
    temp_str <- substr(temp_str[[1]][1], nchar(temp_str[[1]][1])-12, nchar(temp_str[[1]][1]))
    
    id_vec <- c(id_vec, temp_str)
    
    #print(o)
  }
}
