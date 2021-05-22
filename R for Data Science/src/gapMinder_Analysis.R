library(gapminder)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(rmarkdown) # remove
library(scales)

#options(scipen=990000)

rm(list=ls())
setwd("~/dev/training-requirements/R for Data Science")
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[1]<-"id"


# STEP 2 - Filter the data to include only rows where Year is 1962 and then make a scatter plot comparing 'CO2 emissions (metric tons per capita)' and gdpPercap for the filtered data.
gapminder_1962 <- gapminder %>%
  filter(Year==1962)

plot1 <- ggplot(gapminder_1962, aes(x=gdpPercap,y=`CO2 emissions (metric tons per capita)`, size=pop, color=continent))
plot1 <- plot1 + geom_point()
plot1 <- plot1 + scale_x_log10()
plot1 <- plot1 + ggtitle("CO2 Emissions By GDP/Capita")
plot1 <- plot1 + labs(y = "CO2 Emissions (tons/Capita)")
plot1 <- plot1 + labs(x = "GDP/Capita (International Dollars)")
plot1 <- plot1 + scale_x_continuous(labels = comma)
plot1 <- plot1 + ggsave("output/co2_emissions_by_gdp_1962.png")
show(plot1)


# STEP 3 - On the filtered data, calculate the pearson correlation of 'CO2 emissions (metric tons per capita)' and gdpPercap





