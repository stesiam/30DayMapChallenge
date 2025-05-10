## Import libraries

library(ggplot2)
library(sf)
library(ggtext)
library(showtext)
library(osmdata)

font_add_google("Lobster", family = "clim")
font_add_google("EB Garamond", family = "mont")

               
# creating bounding box for Lagos
lamia_bb <- getbb("Lamia")

# retrieving data of streets in Lagos
lamia_streets <- lamia_bb %>%
  opq() %>%
  add_osm_feature("highway", c("motorway", "primary", "secondary", "tertiary")) %>%
  osmdata_sf()

# retrieving data of small streets in Lagos
lamia_small_streets <- lamia_bb %>%
  opq() %>%
  add_osm_feature(key = "highway", value = c("residential", "living_street", "unclassified", "service", "footway")) %>%
  osmdata_sf()

# retrieving data of rivers in Lagos
lamia_rivers <- lamia_bb %>%
  opq() %>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

lamia_fire<- lamia_bb %>%
  opq() %>%
  add_osm_feature("amenity", "fire_station") %>%
  osmdata_sf()      

lamia_police <- lamia_bb %>%
  opq() %>%
  add_osm_feature("amenity", "police") %>%
  osmdata_sf() 

lamia_townhall <- lamia_bb %>%
  opq() %>%
  add_osm_feature("amenity", "townhall") %>%
  osmdata_sf() 


map = ggplot() +
  geom_sf(data = lamia_streets$osm_lines, inherit.aes = FALSE, color = "#ffbe7f", size = .4, alpha = .8) +
  geom_sf(data = lamia_small_streets$osm_lines, inherit.aes = FALSE, color = "#a6a6a6", size = .2, alpha = .8) +
  geom_sf(data = lamia_rivers$osm_lines, inherit.aes = FALSE, color = "#7fc0ff", size = .8, alpha = .5) +
  geom_sf(data = lamia_fire$osm_points, inherit.aes = FALSE, colour = "red2", fill = "red2", alpha = .5, size = 2) +
  geom_sf(data = lamia_police$osm_points, inherit.aes = FALSE, colour = "dodgerblue3", fill = "dodgerblue4", alpha = .5, size = 2) +
  geom_sf(data = lamia_townhall$osm_points, inherit.aes = FALSE, colour = "grey", fill = "black", alpha = .5, size = 2) +
  coord_sf(xlim = c(22.36, 22.48), ylim = c(38.87, 38.94), expand = FALSE) +
  theme_void() +
  labs(
    title = "Major Public Buildings in the city of Lamia",
    subtitle = "**<span style='color:#cd853f;'>Lamia </span>** is a major city which is located on Central Greece. Ignoring
    the fact that <br> the city is relatively small, with just **<span style='color:#cd853f;'> 50000 </span>**
    inhabitants, it is the 19th most <br> populated city of Greece.
    The **<span style='color:red3;'> fire department </span>** is located east of the city, the **<span style='color:dodgerblue3;'> police </span>** <br> station is in the south. 
    Last but not least the **<span style='color:grey;'> townhall </span>** is in the north part of Lamia.",
    caption = "stesiam | Data: Open Street Map"
  ) + 
  theme(
    plot.title = element_markdown(family = "clim", size = 60, hjust = 0.5),
    plot.subtitle = element_markdown(family = "serif", size = 40, margin = margin(t=10,l=20), lineheight = 0.4),
    plot.caption = element_markdown(family = "mont", size = 20, hjust = 0.5)
  )

ggsave(
  filename = "Day 8 - OSM/d8-2022-30dmc.png",
  plot = map,
  device = "png",
  bg = "white",
  width = 7,
  height = 7)

