library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)
library(plotly)

# Q1 - What is the relationship between continent and 'Energy use (kg of oil equivalent per capita)'
rm(list=ls())
setwd("/Users/smerz/dev/training-requirements/R for Data Science/src")
gapminder <- as_tibble(read_csv("../gapminder_clean.csv"))
names(gapminder)[2]<-"country"
names(gapminder)[8]<-"energyUse"

america2007 <- gapminder %>%
  filter(Year==2007, continent=="Americas")

asia2007 <- gapminder %>%
  filter(Year==2007, continent=="Asia")

energyByContinent <- gapminder %>%
  group_by(Year, continent) %>%
  summarize(medianEnergyUse = median(energyUse, na.rm=T))
energyByContinent <- drop_na(energyByContinent)

gap2007 <- gapminder %>%
  filter(Year==2007)

gap2007 <- drop_na(gap2007)
p1 <- ggplot(gap2007, aes(x=gdpPercap,y=energyUse)) +
        geom_point() +
        geom_smooth(method="lm", se = FALSE) +
        ggtitle("Energy Use By GDP per Capita (2007)") +
        labs(y = "Median Energy Use (oil kg/capita)") +
        labs(x = "GDP Per Capita") +
        ggsave("output/q1_energy_use_and_gdp.png")
show(p1)

p1 <- ggplot(energyByContinent, aes(x=Year,y=medianEnergyUse, color=continent)) +
  geom_line() +
  ggtitle("Energy Use By Continent") +
  labs(y = "Median Energy Use (oil kg/capita)") +
  labs(x = "Year") +
  scale_x_continuous(breaks=seq(1962, 2010, by = 5)) +
  ggsave("output/q1_energy_use_over_time.png")
show(p1)

interactive <- ggplotly(p1)
htmlwidgets::saveWidget(as_widget(interactive), "output/q1_energy_use_over_time.html")

# G12 outliers in Asia and Americas
americas_outlier_x <-IQR(america2007$energyUse, na.rm=TRUE) * 1.5 + quantile(america2007$energyUse, na.rm=TRUE)[4]
p1 <- ggplot(america2007, aes(x= energyUse,y=country, size=gdpPercap)) +
  geom_point() +
  ggtitle("Energy Use in the Americas (2007)") +
  labs(x = "Energy Use (oil kg/capita)") +
  labs(y = "Country") +
  scale_x_continuous(breaks=seq(0, 12000, by = 1000)) +
  geom_vline(xintercept = americas_outlier_x, linetype = "dashed",color = "blue", size=0.4) +
  annotate(x=americas_outlier_x,y=+Inf,label="Outlier Boundary",vjust=2,geom="label") +
  ggsave("output/q1_energyUse_americas_2007.png")
show(p1)


asia_outlier_x <- IQR(asia2007$energyUse, na.rm=TRUE) * 1.5 + quantile(america2007$energyUse, na.rm=TRUE)[4]

p1 <- ggplot(asia2007, aes(x=energyUse,y=country, size=gdpPercap)) +
  geom_point() +
  ggtitle("Energy Use in Asia (2007)") +
  labs(x = "Energy Use (oil kg/capita)") +
  labs(y = "Country") +
  scale_x_continuous(breaks=seq(0, 12000, by = 1000)) +
  geom_vline(xintercept =asia_outlier_x , linetype = "dashed",color = "blue", size=0.4) +
  annotate(x=asia_outlier_x,y=+Inf,label="Outlier Boundary",vjust=2,geom="label") +
  ggsave("output/q1_energyUse_asia_2007.png")

show(p1)

