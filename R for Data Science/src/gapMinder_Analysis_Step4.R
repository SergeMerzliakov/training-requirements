library(dplyr)
library(readr)
library(tidyverse)

# STEP 4 - On the unfiltered data, answer "In what year is the correlation between 'CO2 emissions (metric tons per capita)' and gdpPercap the strongest?"
setwd("~/dev/training-requirements/R for Data Science/src/")
rm(list=ls())
gapminder <- as.tibble(read_csv("../gapminder_clean.csv"))
names(gapminder)[5]<-"CO2emissions"

gapminder_emissions_corr <- gapminder %>%
  group_by(Year) %>%
  summarize(pearson_correlation = cor(CO2emissions, gdpPercap,use="pairwise.complete.obs")) %>%
  arrange(desc(pearson_correlation))

max_pearson <- gapminder_emissions_corr[which.max(gapminder_emissions_corr$pearson_correlation),]
print(max_pearson)

