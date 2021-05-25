library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)
library(plotly)

# Q2 - Is there a significant difference between Europe and Asia with respect
# to 'Imports of goods and services (% of GDP)' in the years after 1990?

graphics.off()
rm(list=ls())
setwd("~/dev/training-requirements/R for Data Science")
gapminder <- as.tibble(read_csv("gapminder_clean.csv"))
names(gapminder)[2]<-"country"
names(gapminder)[8]<-"energyUse"
names(gapminder)[12]<-"imports"

eurasia <- gapminder %>%
  filter(Year>1990, continent %in% c("Europe","Asia"))

# review distribution of data
g <- ggplot(eurasia, aes(x=continent,y=imports)) +
  geom_boxplot() +
  facet_wrap(~Year) +
  ggtitle("Review of Distributions of Imports By Continent and Year") +
  ggsave("output/q2_box_plots.png")
show(g)

eurasiaSummary <- eurasia %>%
  group_by(Year, continent) %>%
  summarize(medianImports = median(imports, na.rm=T))

g2 <- ggplot(eurasiaSummary , aes(x=continent, y=medianImports)) +
  geom_col() +
  facet_wrap(~Year) +
  labs(x = "Continents")
show(g2)



