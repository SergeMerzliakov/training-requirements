library(dplyr)
library(readr)
library(tidyverse)
library(scales)
library(here)

rm(list=ls())
set_here()
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[5]<-"CO2emissions"

# STEP 3 - On the filtered data, calculate the pearson correlation of 'CO2 emissions (metric tons per capita)' and gdpPercap
gapminder_1962 <- gapminder %>%
  filter(Year==1962)

correlation <- cor.test(gapminder_1962$CO2emissions, gapminder_1962$gdpPercap) # remove NAs explicitly
print(correlation)

#
# data:  gapminder_1962$CO2emissions and gapminder_1962$gdpPercap
# t = 25.269, df = 106, p-value < 0.00000000000000022
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#   0.8934697 0.9489792
# sample estimates:
#   cor
# 0.9260817



