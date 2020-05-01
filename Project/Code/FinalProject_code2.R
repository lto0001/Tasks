setwd("~/Desktop/Evolution/Tasks/Project/Data")

data <- read.csv("~/Desktop/Evolution/Tasks/Project/Data/urban-and-rural-population_2.csv", stringsAsFactors=F)

install.packages("ggplot2")
library(ggplot2)

p1 <- ggplot() + geom_line(aes(x= Year, y = Urban.population), data = data)
p1 + labs(title = "World Urbanization Rates 1960-2017", x = "Year", y = "Urban population") + scale_x_continuous(breaks = seq(1960, 2020, by = 10)) + scale_y_continuous(labels = scales::comma)
