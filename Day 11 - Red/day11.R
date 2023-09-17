library(dplyr)
library(tidyr)
library(ggplot2)
library(sf)
library(ggtext)
library(glue)
library(osmdata)

library(showtext)
library(sysfonts)

library(rnaturalearth)
library(rnaturalearthdata)

## Load fonts

sysfonts::font_add_google("EB Garamond", "eb")
sysfonts::font_add('fb', '/home/stelios/Downloads/fontawesome-free-5.15.4-desktop/otfs/Font Awesome 6 Brands-Regular-400.otf')


showtext_auto()
showtext::showtext_opts(dpi = 300)

# Import Shapefiles

evia_fire = st_read("Day 11 - Red/Evia/EMSR688_AOI01_DEL_PRODUCT_observedEventA_v2.shp") 
greece_region_map = st_read("Day 11 - Red/nomoi_okxe/nomoi_okxe.shp") 

greece_region_map = greece_region_map %>%
  filter(NAME_ENG == "N. EVVIAS")

## Convert to WGS84

greece_region_map = st_transform(greece_region_map, crs = "EPSG:4326")


title = glue("Wildfire in Euboea Island")
subtitle = glue("On the 21 August 2023 at 08:11 UTC, a wildfire started in a forest area on
                Euboea <br> island in Sterea Ellada Region. The fire is still active. According to
                the Hellenic <br>Fire Service 40 firefighters are currently operating in the area,
                assisted by 2 <br>ground force groups, 29 vehicles, 8 water aircrafts and 7 helicopters.")
caption = glue("Data: Copernicus (EMS Rapid Mapping)<br><span style='font-family:fb; font-size:10px;'>&#xf09b; </span>  stesiam, 2023")

evia_bb = getbb("Euboea")

evia_towns <- evia_bb %>%
  opq() %>%
  add_osm_feature(key = "place", value = "town") %>%
  osmdata_sf()

evia_towns$osm_points = evia_towns$osm_points %>%
  drop_na(`name:en`)


evia_streets <- evia_bb %>%
  opq() %>%
  add_osm_feature("highway", c("motorway", "primary")) %>%
  osmdata_sf()


diffPoly <-evia_towns$osm_points[lengths(st_intersects(evia_towns$osm_points,greece_region_map))==1,]
diffPolyE <-evia_streets$osm_lines[lengths(st_intersects(evia_streets$osm_lines,greece_region_map))==1,]


plot = ggplot2::ggplot(data = greece_region_map) +
  geom_sf(fill = "cornsilk") +
  geom_sf(data = evia_fire, inherit.aes = FALSE, color = "red") +
  geom_sf(data = diffPoly, color = "black") +
  geom_sf_text(data = diffPoly, aes(geometry = geometry, label = `name:en`),
               family = "eb", size = 3, nudge_x = 0.07) + 
  geom_sf(data = diffPolyE, inherit.aes = FALSE, color = "#ffbe7f", size = .4, alpha = .8) +
  labs(
    title = title,
    subtitle = subtitle,
    caption = caption
  ) +
  theme_void(base_size = 13,
             base_family = "eb") +
  theme(
    plot.title = element_markdown(family = "eb", size = 20, hjust = 0.5,
                                  face = "bold"),
    plot.subtitle = element_markdown(family = "eb", margin = margin(t = 20, l = 10, r = 10)),
    plot.caption = element_markdown(family = "eb", margin = margin(b = 3, r = 10),
                                    lineheight = 1.3),
    legend.position = "none"
  )

ggsave(
  filename = "Day 11 - Red/d11-2022-30dmc.png",
  plot = plot,
  device = "png",
  height = 7,
  width = 7,
  bg = "#aedefc"
)
