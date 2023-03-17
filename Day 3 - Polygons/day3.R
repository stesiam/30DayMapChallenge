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

greece_region_map = st_read("Day 3 - Polygons/Greece_Region_Map/d7f50467-e5ef-49ac-a7ce-15df3e2ed738.shp") 

greece_region_map$PER = c("Eastern Macedonia and Thrace","Central Macedonia","Western Macedonia",
                          "Epirus", "Thessaly", "North Aegean", "South Aegean", "Central Greece",
                          "Western Greece", "Peloponnese", "Ionian Islands", "Crete", "Attica")


greece_region_map$Population = c(562069, 1792069, 255056, 
                                 319543, 687527, 194136, 324542, 505269,
                                 643349, 538366, 200726, 617360, 3792469)

## Visualization

map = ggplot2::ggplot(data = greece_region_map) +
  geom_sf(aes(fill = PER)) +
  labs(
    title = "Greece's Regions",
    subtitle = "Greece is divided in 13 regions (first level administrative entities). <br> 
    Biggest region is **Central Macedonia**. <br> 
    The most populated region is **Attica**,",
    caption = "**stesiam**, 2023 | Data : &nbsp; geodata.gov.gr"
  )+
  theme_void() +
  theme(
    plot.title = element_markdown(family = "clim", size = 60, hjust = 0.5, face = "bold"),
    plot.subtitle = element_markdown(family = "mont", size = 25, hjust = 0.5, lineheight = 0.4),
    plot.caption = element_markdown(family = "mont", size = 23, hjust = 0.5),
    legend.position = "none"
  )


ggsave(
  filename = "Day 3 - Polygons/d3-2022-30dmc.png",
  plot = map,
  device = "png",
  bg = "grey88")

