# Scripting to produce maps for the Mapping in R PEAKS presentation, 2015-07-31
# EByerly

rm(list = ls())
gc()
sink()

setwd("~/mapping_in_r")

stamp <- format(Sys.time(), "%F %H%M")
output_path <- file.path("Outputs", stamp)
sapply(c(output_path, "Inputs"),
       dir.create, recursive = TRUE, showWarnings = FALSE)
sink(file.path(output_path, paste0("00_", stamp, ".log")), split = TRUE)

source("01_Environment.R", echo = TRUE, max.deparse.length = 9e9)
source("02_Rasters.R", echo = TRUE, max.deparse.length = 9e9)
source("03_Vectors.R", echo = TRUE, max.deparse.length = 9e9)
source("04_Shapefiles.R", echo = TRUE, max.deparse.length = 9e9)
source("05_HUD_Multifamily.R", echo = TRUE, max.deparse.length = 9e9)

sink()
