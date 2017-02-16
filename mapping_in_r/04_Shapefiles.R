# ==============================================================================
# Shapefile Maps

usaShp <- function(url) {
  download.file(url, file.path("Inputs", basename(url)))
  unzip(file.path("Inputs", basename(url)), exdir = "Inputs")
  usa <- readOGR(dsn = "Inputs", basename(tools::file_path_sans_ext(url)))
  usa@data$id = rownames(usa@data)
  usa.points = fortify(usa, region = "id")
  county = join(usa.points, usa@data, by = "id")
  county[!(county$STATEFP %in% c("02", "15") | county$STATEFP > 56), ]
}

county <- usaShp("http://www2.census.gov/geo/tiger/GENZ2014/shp/cb_2014_us_county_500k.zip")
states <- usaShp("http://www2.census.gov/geo/tiger/GENZ2014/shp/cb_2014_us_state_500k.zip")

shp_proj <- ggplot(aes(x = long, y = lat), data = county) +
  geom_polygon(aes(group = group, fill = STATEFP),
               color = "grey95") +
  coord_map("ortho", orientation = c(41, -74, 0)) +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text = element_blank(),
        plot.background = element_blank())
ggsave(shp_proj, filename = file.path(output_path, "04_shp_proj.png"),
       scale = 2)

# Create maps combining raster and vector maps
usa_raster <- get_stamenmap(bbox(obj = as.matrix(county[,c("long", "lat")])),
                            maptype = "watercolor", zoom = 6)

mix <- ggmap(usa_raster, extent = "device",
      base_layer = ggplot(aes(x = long, y = lat, group = group),
                          data = county)) +
  geom_polygon(aes(fill = STATEFP, color = STATEFP), alpha = .3) +
  coord_map(projection = "mercator") +
  theme(legend.position = "none")
ggsave(mix, filename = file.path(output_path, "04_mix.png"),
       scale = 2)

overlay <- ggmap(usa_raster, extent = "device",
      base_layer = ggplot(aes(x = long, y = lat, group = group),
                          data = county)) +
  geom_path(color = "grey90", alpha = .6) +
  geom_path(color = "white", alpha = .9, data = states) +
  coord_map(projection = "mercator") +
  theme(legend.position = "none")
ggsave(overlay, filename = file.path(output_path, "04_overlay.png"),
       scale = 2)

