# ==============================================================================
# Vector/Polygon Maps

world <- map_data("world")
worldmap <- ggplot(world,
                   aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = region)) +
  geom_path(color = "black") +
  scale_y_continuous(breaks=(-2:2) * 30) +
  scale_x_continuous(breaks=(-4:4) * 45) +
  theme(legend.position = "none") +
  theme(plot.background = element_blank())
ggsave(worldmap +
         theme(axis.title = element_blank(), axis.text = element_blank()),
       filename = file.path(output_path, "03_worldmap.png"),
       width = 13, height = 7.5)
ggsave(worldmap +
         coord_map("ortho") +
         theme(axis.title = element_blank(), axis.text = element_blank()),
       filename = file.path(output_path, "03_worldmap_ortho.png"),
       scale = 2)
ggsave(worldmap +
         coord_map("ortho", orientation=c(41, -74, 0)) +
         theme(axis.title = element_blank(), axis.text = element_blank()),
       filename = file.path(output_path, "03_worldmap_ortho_nyc.png"),
       scale = 2)
