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

greece_region_map = st_read("Day 4 - Green/Greece_Region_Map/d7f50467-e5ef-49ac-a7ce-15df3e2ed738.shp") 

## Rename regions

greece_region_map$PER = c("Eastern Macedonia and Thrace","Central Macedonia","Western Macedonia",
                          "Epirus", "Thessaly", "North Aegean", "South Aegean", "Central Greece",
                          "Western Greece", "Peloponnese", "Ionian Islands", "Crete", "Attica")

## Add observations

greece_region_map$pharmacies = c(569, 1976, 242, 322, 802, 183, 279, 433, 645, 521, 195, 586, 3674)


# Visualization

map = ggplot2::ggplot(data = greece_region_map) +
  geom_sf(aes(fill = pharmacies)) +
  geom_sf_text(aes(label = round((pharmacies)/100)),
               colour = "black", 
               size = 13,
               family="mont") +
  labs(
    title = "Pharmacies in Greece",
    subtitle = "Total number (in hundrends) of Pharmacy Stores in Greece (2022, regional data)",
    caption = "**stesiam** | Data : Hellenic Statistical Authority"
  ) +
  scale_fill_gradient(low='white', high='green3') +
  theme_void() +
  theme(
    plot.title = element_markdown(family = "clim", size = 60, hjust = 0.5),
    plot.subtitle = element_markdown(family = "mont", size = 25, hjust = 0.5),
    plot.caption = element_markdown(family = "mont", size = 20, hjust = 0.5),
    legend.position = "none"
  )

ggsave(
  filename = "Day 4 - Green/d4-2022-30dmc.png",
  plot = map,
  device = "png",
  bg = "white")
