# Hypothesis: Did learning the skill to crawl fully increase the rate Beren's milk 

# Read in data & set up working directory
setwd("~/Desktop/Evolution/Tasks/Task_02")
beren3 <- read.csv("beren_new.csv", stringsAsFactors = F)

# Find which row he learned to crawl
Skill <- which(beren3$event == "skill_crawl_full")

# Find day he learned to crawl
Age <- beren3[Skill, "age"]

# Subset data by older and younger than day he learned to crawl
berenYounger <- beren3[which(beren3$age < Age),]
berenOlder <- beren3[which(beren3$age > Age),]

# Subset berenYounger to be only bottle feeds
Feeds <- which(berenYounger$event == "bottle")

# Use mean() on value column to get overall avg milk for subset younger
youngerOverallAvgMilk <- mean(berenYounger$value["Feeds"])

# Use tapply() on value & age to get per-day avg milk for younger
youngerPerDayAvgMilk <- tapply(berenYounger$value[Feeds], berenYounger$age[Feeds], mean)

# Use mean() on youngerPerDayAvgMilk to get avg milk before crawl
beforeAvgMilk <- mean(youngerPerDayAvgMilk

### Repeat above 4 steps for older
olderOverallAvgMilk <- 
