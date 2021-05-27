library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)

rm(list=ls())
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[5]<-"CO2emissions"

# STEP 2 - Filter the data to include only rows where Year is 1962 and then make a scatter plot comparing 'CO2 emissions (metric tons per capita)' and gdpPercap for the filtered data.
gapminder_1962 <- gapminder %>%
  filter(Year==1962)

scatter62 <- ggplot(gapminder_1962, aes(x=gdpPercap,y=CO2emissions, size=pop, color=continent)) +
  geom_point() +
  scale_x_log10() +
  ggtitle("CO2 Emissions By GDP/Capita - 1962") +
  labs(y = "CO2 Emissions (tons/Capita)") +
  labs(x = "GDP/Capita (International Dollars)") +
  scale_x_continuous(labels = comma)






