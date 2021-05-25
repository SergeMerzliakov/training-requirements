library(dplyr)
library(readr)
library(tidyverse)
library(here)

# STEP 4 - On the unfiltered data, answer "In what year is the correlation between 'CO2 emissions (metric tons per capita)' and gdpPercap the strongest?"
rm(list=ls())
set_here()
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[5]<-"CO2emissions"

gapminder_emissions_corr <- gapminder %>%
  group_by(Year) %>%
  summarize(pearson = cor(CO2emissions, gdpPercap,use="pairwise.complete.obs"))

max_pearson <- gapminder_emissions_corr[which.max(gapminder_emissions_corr$pearson),]
print(max_pearson)

