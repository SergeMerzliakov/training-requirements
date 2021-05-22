library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)

# STEP 5 - Filter the dataset to 1967, year with highest correlation coefficient
rm(list=ls())
setwd("~/dev/training-requirements/R for Data Science")
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[5]<-"CO2emissions"

gapminder_1967 <- gapminder %>%
  filter(Year == 1967)

plot1 <- ggplot(gapminder_1967, aes(x=gdpPercap,y=CO2emissions, size=pop, color=continent))
plot1 <- plot1 + geom_point()
plot1 <- plot1 + scale_x_log10()
plot1 <- plot1 + ggtitle("CO2 Emissions By GDP/Capita - 1967")
plot1 <- plot1 + labs(y = "CO2 Emissions (tons/Capita)")
plot1 <- plot1 + labs(x = "GDP/Capita (International Dollars)")
plot1 <- plot1 + ylim(0, 50)
plot1 <- plot1 + scale_x_continuous(labels = comma)
plot1 <- plot1 + ggsave("output/co2_emissions_by_gdp_1967.png")
show(plot1)

