## Libraries

library(ggplot2)
library(sf)
library(ggtext)
library(showtext)
library(readr)

## Add fonts

font_add_google("Righteous", family = "clim")
font_add_google("Montserrat", family = "mont")

showtext_auto()

## Read shapefile and point (school) coord data

greece_map <- st_read("Day 1 - Points/data/GRC_adm0.shp") 
music_schools_coord <- read_csv("Day 1 - Points/music_schools.csv")

## Visualization

map = ggplot2::ggplot(data = greece_map) +
  geom_sf() +
  geom_point(data=music_schools_coord, 
             aes(x=Longitude, y=Latitude), colour="Deep Pink", 
             fill="Pink",pch=21, size=2, alpha=I(0.7)) +
  labs(
    title = "Greece's Public Music Schools",
    subtitle = "Point map of every public music school in Greece (elementary or high school) <br>
    Total number of music schools in Greece is **52**.<br>
    The region with the most is **Attica**",
    caption = "**stesiam**, 2023 | Data : &nbsp; Hellenic &nbsp; Ministry of &nbsp;  &nbsp;  &nbsp; Education"
  )+
  theme_void() +
  theme(
    plot.title = element_markdown(family = "clim", size = 60, hjust = 0.5),
    plot.subtitle = element_markdown(family = "mont", size = 25, hjust = 0.5, lineheight = 0.4),
    plot.caption = element_markdown(family = "mont", size = 20, hjust = 0.5),
  )

ggsave(
  filename = "Day 1 - Points/d1-2022-30dmc.png",
  plot = map,
  device = "png",
  bg = "white")

