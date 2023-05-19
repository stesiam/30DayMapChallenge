#library(rgdal)
library(raster)
library(ggplot2)
library(here)
library(showtext)
library(ggtext)

# Computationally intense script - Use Kaggle 

## Add fonts

font_add_google("EB Garamond", family = "pac")
font_add_google("Montserrat", family = "mont")


## Import EU Population Raster file

rs = raster(here("Day 7 - Raster","JRC_1K_POP_2018.tif"))

rs = stack(here("Day 7 - Raster","JRC_1K_POP_2018.tif"))

rs = rs %>% 
  as.data.frame(.,xy=T) %>%
  na.omit()


map = ggplot(data = rs) +
  geom_raster(aes(x = x, y = y, fill = JRC_1K_POP_2018)) +
  scale_x_continuous(limits = c(2700000, 6500000)) +
  scale_y_continuous(limits = c(1380000, 5300000)) +
  labs(
    title = "Population in EU",
    caption = "**stesiam** | **Data :** Eurostat (GISCO)"
  ) +
  theme_void() +
  theme(
    plot.title = element_markdown(family = "serif", size = 35, hjust = 0.5),
    plot.caption = element_markdown(family = "serif", size = 10, hjust = 0.5),
    legend.position = "none"
  )

ggsave(
  filename = "d7-2022-30dmc.png",
  plot = map,
  device = "png",
  bg = "white",
  height = 7,
  width = 7)