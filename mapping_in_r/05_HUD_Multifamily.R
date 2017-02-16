# ==============================================================================
# Sourcing Data to Graph on Our Map

hud_url <- "http://docs.huduser.org/gis/FGDB/HudInsuredOwned.gdb.zipx"
download.file(hud_url,
              file.path("Inputs", "HudInsuredOwned.gdb.zipx"), mode = "wb")
system("7z x -y Inputs/HudInsuredOwned.gdb.zipx")

download.file("http://quickfacts.census.gov/qfd/download/DataSet.txt",
              file.path("Inputs", "DataSet.txt"), mode = 'wb')
county_pop <- read.csv(file.path("Inputs", "DataSet.txt"))
county_pop$fips <- stringr::str_pad(county_pop$fips, 5, "left", "0")

plottable <- function(curr_layer) {
  usa <- readOGR(file.path("Inputs", "HudInsuredOwned.gdb"),
                 layer = curr_layer)
  usa@data$id <- rownames(usa@data)
  usa@data
}

ogrListLayers(file.path("Inputs", "HudInsuredOwned.gdb"))
insured <- plottable("MULTIFAMILY_PROPERTIES_INSURED")
insured <- insured[!(insured$STD_ST %in% c("HI", "AK", "PR")),]

# ==============================================================================
# Dot density

dot_density <- ggplot(aes(x = long, y = lat), data = states) +
  geom_polygon(aes(group = group), color = "grey95") +
  geom_point(aes(x = LON, y = LAT), color = "#2db6e8", alpha = .6,
             data = insured) +
  coord_map() +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.background = element_blank(),
        panel.grid = element_blank())
ggsave(dot_density, filename = file.path(output_path, "05_dot_density.png"),
       scale = 2)

# ==============================================================================
# Choropleth

cnty_trouble <- insured %>%
  group_by(COUNTY_LEVEL) %>%
  summarise("Trouble" = sum(TROUBLED_CODE != "N", na.rm = TRUE) / n())

county$COUNTY_LEVEL <- paste0(county$STATEFP, county$COUNTYFP)
county <- merge(county, cnty_trouble, all.x = TRUE)
county <- county[order(county$order),]

choropleth <- ggplot(aes(x = long, y = lat), data = county) +
  geom_polygon(aes(group = group, fill = Trouble)) +
  scale_fill_gradient(na.value = "grey90") +
  coord_map() +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.background = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank())

ggsave(choropleth, filename = file.path(output_path, "05_choropleth.png"),
       scale = 2)

# ==============================================================================
# Graduated scale

cnty_count <- insured %>%
  group_by(COUNTY_LEVEL) %>%
  summarise("Unit_Total" = sum(TOTAL_UNIT_COUNT),
            "LAT" = median(LAT),
            "LON" = median(LON))

graduated_scale <- ggplot(aes(x = long, y = lat), data = states) +
  geom_polygon(aes(group = group), color = "grey95") +
  geom_point(aes(x = LON, y = LAT, size = Unit_Total), color = "grey85",
             data = cnty_count, shape = 21, fill = "#2db6e8") +
  scale_size_continuous(range = c(2, 12)) +
  coord_map() +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.background = element_blank(),
        panel.grid = element_blank())

ggsave(graduated_scale, filename = file.path(output_path, "05_graduated_scale.png"),
       scale = 2)

# ==============================================================================
# Isopleth

insured <- merge(insured, county_pop[,c("fips", "PST045214")],
                 by.x = "COUNTY_LEVEL", by.y = "fips", all.x = TRUE)
cnty_by_unit <- insured %>%
  group_by(COUNTY_LEVEL, CLIENT_GROUP_TYPE) %>%
  summarise("Unit_Total" = sum(TOTAL_ASSISTED_UNIT_COUNT),
            "Units_Per_Pop" = Unit_Total / unique(PST045214),
            "LAT" = median(LAT),
            "LON" = median(LON))

dmv <- c(11, 24, 51)
dmv_by_unit <- cnty_by_unit[substr(cnty_by_unit$COUNTY_LEVEL, 1, 2) %in% dmv,]
dmv_by_unit$Units_Per_Pop <- dmv_by_unit$Units_Per_Pop + .000001
dmv_insured <- insured[substr(insured$COUNTY_LEVEL, 1, 2) %in% dmv,]

dmv_county <- county[county$STATEFP %in% dmv,]

dmv_insured <- dmv_insured[dmv_insured$LON > -78 & dmv_insured$LAT > 38 &
                             dmv_insured$CLIENT_GROUP_TYPE %in% c("Disabled", "Family"),]

dmv_map <- get_stamenmap(bbox(obj = as.matrix(dmv_insured[,c("LON", "LAT")])),
                         maptype = "toner-background", zoom = 9)

isopleth <- ggmap(dmv_map, extent = "device",
                  base_layer = ggplot(aes(x = LON, y = LAT, fill = CLIENT_GROUP_TYPE),
                                      data = dmv_insured)) +
                    stat_density2d(aes(alpha = ..level..), bins = 3, geom = "polygon") +
                    scale_alpha_continuous(guide = FALSE) +
                    coord_map()
ggsave(isopleth, filename = file.path(output_path, "05_isopleth.png"))
