# Import libraries

library(ggplot2)
library(starBliss)

# Star Map

p<- plot_starmap(location= "Athens, Greece",
                 date="2022-05-21",
                 style="black",
                 line1_text="Athens",
                 line2_text ="May 21st, 2023")
# Export Map

ggsave(
  filename = "Day 9 - Space/d9-2022-30dmc.png",
  plot = p,
  device = "png",
  width = unit(10, 'in'), 
  height = unit(15, 'in'),
  scale = 0.7
)

