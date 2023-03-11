## Libraries

library(ggplot2)
library(sf)
library(ggtext)
library(showtext)

## Add fonts

font_add_google("Righteous", family = "clim")
font_add_google("Montserrat", family = "mont")

showtext_auto()

## Read shapefile and point (school) coord data

greece_map = st_read("Day 2 - Lines/Greece_Map/GRC_adm0.shp") 
greece_rail = st_read("Day 2 - Lines/Greece_Rail/cd6cca01-996f-4120-8ff2-96e094e8d405.shp") 

## Visualization

map = ggplot2::ggplot() +
  geom_sf(data = greece_map) +
  geom_sf(data = greece_rail,
          size = 1,
          colour = "blue") +
  labs(
    title = "Railway Network of Greece",
    caption = "**stesiam**, 2023 | Data : &nbsp; geodata.gov.gr"
  )+
  theme_void() +
  theme(
    plot.title = element_markdown(family = "mont", size = 60, hjust = 0.5, face = "bold"),
    plot.subtitle = element_markdown(family = "mont", size = 30, lineheight = 4),
    plot.caption = element_markdown(family = "mont", size = 25, lineheight = 4)
  )

ggsave(
  filename = "Day 2 - Lines/greek_railway-30dmc.png",
  plot = map,
  device = "png",
  bg = "white")
