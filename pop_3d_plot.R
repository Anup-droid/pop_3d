library(sf)
library(maps)
library(rayshader)
library(ggplot2)
library(tidyverse)
library(viridis)
library(viridisLite)
library(reshape2)
library(rayrender)
library(av)
library(ggdark)

#Data Import
ind <- read_excel("C:/Users/Anup Kumar/Downloads/ind.xlsx")

# Convert data to long format
pop_ind <- pivot_longer(ind,
                        cols = -Year,
                        names_to = "Age_Category",
                        values_to = "Population")
#Plot Graph
pop_gg = ggplot(pop_ind) +
  geom_raster(aes(x = Year, y = Age_Category, fill = Population)) +
  scale_x_continuous("Year", breaks = seq(1950, 2021, 10)) +
  scale_fill_viridis(
    "Population (in million)",
    breaks = c(1000000, 234000000, 467000000, 700000000),
    labels = c("1", "234", "467", "700")
  ) +
  ylab("Age Category")+
  dark_theme_classic()+
  theme(panel.grid = element_blank())+
  labs(title = "Population by Age Group,India 1950-2021 ",
         caption = "Source: United Nations, World Population Prospects (2022)")

#Make 3D Plot
plot_gg(pop_gg,height = 5, width = 6 )

#Make Movie
render_movie(filename = "pop.mp4",type = "orbit",frames = 360)

