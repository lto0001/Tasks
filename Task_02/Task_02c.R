# Hypothesis: Did learning the skill to crawl fully increase the rate of Beren's milk per feeding in ounces

# Read in data & set up working directory
setwd("~/Desktop/Evolution/Tasks/Task_02")
beren3 <- read.csv("beren_new.csv", stringsAsFactors = F)

# Find which row he learned to crawl
Skill <- which(beren3$event == "skill_crawl_full")
Skill <- grep("high", beren3$event)

# Find day he learned to crawl
Age <- beren3[Skill, "age"]

# Subset data by older and younger than day he learned to crawl
berenYounger <- beren3[which(beren3$age < Age),]
berenOlder <- beren3[which(beren3$age > Age),]

# Subset berenYounger to be only bottle feeds
Feeds <- which(berenYounger$event == "bottle")

# Use mean() on value column to get overall avg milk for subset younger
youngerOverallAvgMilk <- mean(berenYounger$value[Feeds])

# Use tapply() on value & age to get per-day avg milk for younger
youngerPerDayAvgMilk <- tapply(berenYounger$value[Feeds], berenYounger$age[Feeds], mean)

# Use mean() on youngerPerDayAvgMilk to get avg milk before crawl
beforeAvgMilk <- mean(youngerPerDayAvgMilk)

### Repeat above 4 steps for older
Feeds <- which(berenOlder$event == "bottle")
olderOverallAvgMilk <- mean(berenOlder$value[Feeds])
olderPerDayAvgMilk <- tapply(berenOlder$value[Feeds], berenOlder$age[Feeds], mean)

#Now make a pot but dont use cammand z and compare older and younger (two plots)

boxplot(youngerPerDayAvgMilk, olderPerDayAvgMilk)
par(mfrow=c(1,2))
plot(as.numeric(names(youngerPerDayAvgMilk)), youngerPerDayAvgMilk, type="b" , xlab="Age in Days" , ylab="Ounces of Milk" , main="Before Learning to Crawl Full")
plot(as.numeric(names(olderPerDayAvgMilk)), olderPerDayAvgMilk, type="b" , xlab="Age in days" , ylab="Ounces of milk" , main="After Learning to Crawl Full ")

#To label x axis use "xlab", to label y axis use "ylab", and to title a graph use "main" 
