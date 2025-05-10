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


lux_bus_line = st_read("Day 6 - Network/Luxembourg_Bus_Lines/Cdt - Buslinnen AVL_ln.shp") 
lux_bus_point = st_read("Day 6 - Network/Luxembourg_Bus_Lines/Cdt - Buslinnen AVL_pt.shp")
lux = st_read("Day 6 - Network/limadmin-shp/LIMADM_CANTONS.shp")

lux = lux %>%
  dplyr::filter(CANTON == "Luxembourg")

# Visualization

map = ggplot2::ggplot() +
  geom_sf(data = lux,
          fill = "white") +
  geom_sf(data = lux_bus_line,
          color = "blue4") +
  geom_sf(data = lux_bus_point,
          color = "black"
  ) +
  labs(
    title = "Bus Transportation in Luxembourg City",
    caption = "**stesiam** | **Data :** data.europa.eu"
  ) +
  theme_void() +
  theme(
    plot.title = element_markdown(family = "clim", size = 60, hjust = 0.5),
    plot.caption = element_markdown(family = "mont", size = 20, hjust = 0.5),
    legend.position = "none"
  )

ggsave(
  filename = "Day 6 - Network/d6-2022-30dmc.png",
  plot = map,
  device = "png",
  bg = "#ffc9bb",
  width = 7,
  height = 7)

