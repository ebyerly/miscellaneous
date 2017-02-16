options(stringsAsFactors = FALSE)

pkgs <- c("ggplot2", "ggmap", "plyr", "readxl", "sp", "maptools", "rgdal", "dplyr")
plyr::l_ply(pkgs, library, character.only = TRUE)

gpclibPermit()
