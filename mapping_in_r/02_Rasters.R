# ==============================================================================
# Raster maps

# Generate the first map
ggsave(plot = qmap("601 New Jersey Ave NW, Washington, DC", zoom = 18),
       filename = file.path(output_path, "02_First_Map.png"),
       scale = 2)

# Generate the first map plot
eg <- data.frame(geocode(c("601 New Jersey Ave NW, Washington, DC",
                           "Union Station Metro, Washington, DC",
                           "Judiciary Square Metro, Washington, DC")))
tmp <- qmplot(data = eg, x = lon, y = lat, zoom = 18, f = 1.1,
              xlim = range(eg$lon))
ggsave(tmp, filename = file.path(output_path, "02_First_Map_Graphic.png"),
       scale = 2)

# Exhibit of simple raster map types
stamen_maptypes <- c("watercolor", "toner-2011", "toner-lines", "toner-lite",
                     "terrain-background")
l_ply(stamen_maptypes, function(x) {
  ggsave(plot = ggmap(get_map("601 New Jersey Ave NW, Washington, DC",
                              zoom = 12, source = "stamen", maptype = x),
                      extent = "device") +
           theme(plot.background = element_blank()),
         filename = file.path(output_path, paste0("02_", x, ".png")), scale = 2)
})
