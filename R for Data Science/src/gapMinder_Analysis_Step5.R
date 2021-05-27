library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(plotly)

graphics.off()
# STEP 5 - Filter the dataset to 1967, year with highest correlation coefficient
rm(list=ls())
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[5]<-"CO2emissions"

gapminder_1967 <- gapminder %>%
  filter(Year == 1967)

 plot67 <- ggplot(gapminder_1967, aes(x=gdpPercap,y=CO2emissions, size=pop, color=continent)) +
  geom_point() +
  scale_x_log10(labels = comma) +
  scale_y_log10() +
  ggtitle("CO2 Emissions By GDP/Capita - 1967") +
  labs(y = "CO2 Emissions (tons/Capita)") +
  labs(x = "GDP/Capita (International Dollars)") +
ggplotly(plot67)


# generate interactive plotly plot and export as HTML
interactive <- ggplotly(plot1)


