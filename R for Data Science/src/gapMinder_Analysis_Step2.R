library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)
library(here)

rm(list=ls())
set_here()
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[5]<-"CO2emissions"

# STEP 2 - Filter the data to include only rows where Year is 1962 and then make a scatter plot comparing 'CO2 emissions (metric tons per capita)' and gdpPercap for the filtered data.
gapminder_1962 <- gapminder %>%
  filter(Year==1962)

plot1 <- ggplot(gapminder_1962, aes(x=gdpPercap,y=CO2emissions, size=pop, color=continent))
plot1 <- plot1 + geom_point()
plot1 <- plot1 + scale_x_log10()
plot1 <- plot1 + ggtitle("CO2 Emissions By GDP/Capita - 1962")
plot1 <- plot1 + labs(y = "CO2 Emissions (tons/Capita)")
plot1 <- plot1 + labs(x = "GDP/Capita (International Dollars)")
plot1 <- plot1 + scale_x_continuous(labels = comma)
plot1 <- plot1 + ggsave("output/co2_emissions_by_gdp_1962.png")
show(plot1)





