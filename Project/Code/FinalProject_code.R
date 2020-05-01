setwd("~/Desktop/Evolution/Tasks/Project/Data")

data <- read.csv("~/Desktop/Evolution/Tasks/Project/Data/iucn_turtles.csv", stringsAsFactors=F, fill=TRUE)

vulnerable <- c(11, 13, 4, 21, 1, 19)
#For vulnerable: Nearctic (11), Afro (13), Aus(4), Neo(21), Pal(1), Indo(19)

critical <- c(4, 9, 2, 10, 6, 19)
#For critical: Nearctic(4), Afro(9), Aus(2), Neo(10), Pal(6), Indo(19)

threatened <- c(6, 2, 1, 4, 1, 0)
#For threatened: Nearctic(6), Afro(2), Aus(1), Neo(4), Pal(1), Indo(0)

LowRisk <- c(1, 3, 4, 13, 2, 8)
#For Lower Risk: Nearctic(1), Afro(3), Aus(4), Neo(13), Pal(2), Indo(8)

LeastConcern <- c(25, 4, 1, 5, 1, 0)
#For least concern: Nearctic(25), Afro(4), Aus(1), Neo(5), Pal(1), Indo(0)

endangered <- c(7, 4, 4, 7, 3, 19)
#For endangered: Neartic(7), Afro(4), Aus(4), Neo(7), Pal(3), Indo(19)

extinct <- c(0, 6, 0, 2, 0, 1)
#For extinct: Neartic(0), Afro(6), Aus(0), Neo(2), Pal(0), Indo(1)

DataDeficient <- c(0, 2, 3, 5, 1, 1)
#For data deficient: Neartic(0), Afro(2), Aus(3), Neo(5), Pal(1), Indo(1)

par(mar = c(5,4,4,8))

barplot(rbind(vulnerable, critical, threatened, LowRisk, LeastConcern, endangered, extinct, DataDeficient), names.arg = c("Nearctic", "Afrotropical", "Australasian", "Neotropical", "Palearctic", "Indomalayan"), legend.text = c("vulnerable", "critical", "threatened", "LowRisk", "LeastConcern", "endangered", "extinct", "DataDeficient"), beside = TRUE, xlab = "Realm", ylab = "Number of Turtles", args.legend = list(x = "right", inset=c(-0.24,0), xpd = TRUE))

#Hypothesis:Extinction rates are positively correlated with habitat type in turtles. 
#Why do more human populated areas have small population of turtles? 