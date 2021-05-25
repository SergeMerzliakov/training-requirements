library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)
library(plotly)
library(here)

# Q3 - What is the country (or countries) that has the highest 'Population density (people per sq. km of land area)'
# across all years? (i.e., which country has the highest average ranking in this category across each time
# point in the dataset?)

graphics.off()
rm(list=ls())
set_here()
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[2]<-"country"
names(gapminder)[8]<-"energyUse"
names(gapminder)[12]<-"imports"









