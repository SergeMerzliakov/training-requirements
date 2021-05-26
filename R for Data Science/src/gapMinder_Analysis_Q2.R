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
  labs(x = "Continent") +
  labs(y = "Imports (% of GDP)") +
  ggtitle("Review of Distributions of Imports By Continent and Year") +
  ggsave("output/q2_box_plots.png")
show(g)

eurasiaSummary <- eurasia %>%
  group_by(Year, continent) %>%
  summarize(medianImports = median(imports, na.rm=T))

# review basic data for obvious trends
g2 <- ggplot(eurasiaSummary , aes(x=continent, y=medianImports,fill=continent)) +
  geom_col() +
  facet_wrap(~Year) +
  labs(x = "Continent") +
  labs(y = "Imports (% of GDP)") +
  ggtitle("Imports By Continent and Year") +
  ggsave("output/q2_basic_trends.png")
show(g2)

# Normality Test - Shapiro Wilks
for(Y in seq(from=1992, to=2007, by=5)){
  asia <- eurasia %>% filter(continent=="Asia", Year==Y) %>% select(imports)
  europe <- eurasia %>% filter(continent=="Europe", Year==Y)  %>% select(imports)
  shap_asia <- shapiro.test(asia$imports)
  shap_europe <- shapiro.test(europe$imports)

  if (shap_asia$p.value < 0.05){
    # accept H1 - Not a Normal Dist.
    print(paste("Year ", Y, " - Sample is Not Normal Dist p=", shap_asia$p.value))
  }else{
    # accept Ho - Dist IS Normal
    print(paste("Year ", Y, " - Sample is Normal Dist p=", shap_asia$p.value))
  }

  if (shap_europe$p.value < 0.05){
    # accept H1 - Not a Normal Dist.
    print(paste("Year ", Y, " - Sample is Not Normal Dist p=", shap_europe$p.value))
  }else{
    # accept Ho - Dist IS Normal
    print(paste("Year ", Y, " - Sample is Normal Dist p=", shap_europe$p.value))
  }
}

print("----------------------------------------------------------")

# test variance across all years
for(Y in seq(from=1992, to=2007, by=5)){
  asia <- eurasia %>% filter(continent=="Asia", Year==Y) %>% select(imports)
  europe <- eurasia %>% filter(continent=="Europe", Year==Y)  %>% select(imports)
  bt <- var.test(asia$imports, europe$imports)
  if (bt$p.value > 0.05){
    print(paste("Year ", Y, " - Samples Have Same Variance. p=", bt$p.value))
  }else{
    print(paste("Year ", Y, " - Samples Have Different Variance. p=",bt$p.value))
  }
}

print("----------------------------------------------------------")
# Heteroscedastic - use Wilcoxon Rank Sum across all years
for(Y in seq(from=1992, to=2007, by=5)){
  asia <- eurasia %>% filter(continent=="Asia", Year==Y) %>% select(imports)
  europe <- eurasia %>% filter(continent=="Europe", Year==Y)  %>% select(imports)
  wt <- wilcox.test(asia$imports, europe$imports)
  print(paste("Year ", Y, " - Wilcoxon Rank Sum. p=",wt$p.value))
}

# conclusion -  medians not significantly different - no significant difference between European and Asian imports








