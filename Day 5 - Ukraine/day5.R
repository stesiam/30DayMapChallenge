## Libraries

library(ggplot2)
library(sf)
library(ggtext)
library(showtext)

## Add fonts

font_add_google("Righteous", family = "clim")
font_add_google("Montserrat", family = "mont")

showtext_auto()


## Read shapefile



ukraine_map = st_read("Day 5 - Ukraine/Ukraine_Map/UKR_adm0.shp") 
ukraine_ports = st_read("Day 5 - Ukraine/Ukr_Ports/hotosm_ukr_sea_ports_points.shp")

# Visualization

map = ggplot2::ggplot(data = ukraine_map) +
  geom_sf() +
  geom_sf(data = ukraine_ports,
          color = "blue"
          ) +
  labs(
    title = "Ports in Ukraine",
    caption = "**stesiam** | **Data :** Humanitarian OpenStreetMap Team (HOT) - data.humdata.org"
  ) +
  theme_void() +
  theme(
    plot.title = element_markdown(family = "clim", size = 60, hjust = 0.5),
    plot.caption = element_markdown(family = "mont", size = 20, hjust = 0.5),
    legend.position = "none"
  )

ggsave(
  filename = "Day 5 - Ukraine/d5-2022-30dmc.png",
  plot = map,
  device = "png",
  bg = "#f7f5bc",
  height = 7,
  width = 7)

