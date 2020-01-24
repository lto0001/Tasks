setwd("~/Desktop/Evolution/Tasks/Task_02")
Data <- read.csv("http://jonsmitchell.com/data/beren.csv", stringsAsFactors=F)
write.csv(Data, "rawdata.csv", quote=F)
length(Data)
nrow(Data)
ncol(Data)
colnames(Data)
head(Data)
Data[1,]
Data[2,]
Data[1:3,]
Data[1:3, 4]
Data[1:5, 1:3]

Feeds <- which(Data[,9] == "bottle")
berenMilk <- Data[Feeds,]
head(berenMilk)
Feeds <- which(Data[, "event"] == "bottle")
Feeds <- which(Data$event == "bottle")

dayID <- apply(Data, 1, function(x) paste(x[1:3], collapse="-"))
dateID <- sapply(dayID, as.Date, format = "%Y-%m-%d", origin = "2019-04-18")
Data$age <- dateID - dateID[which(Data$event == "birth")]
head(Data)
beren2 <- Data
beren3 <- beren2[order(beren2$age) ,]
write.csv(beren3, "beren_new.csv", quote=F, row.names=FALSE)

#Question 1: After looking at the data his weight and food consumption are not done simultaneously. They do not weigh him ever day but he does eat every day. For the second hypothesis, we do not know how logn he spends at day care each day. So creating a relationship between naps and milk consumption would have missong data.  

# Setting up for Task 02b
setwd()
beren3 <- read.csv("beren_new.csv", stringsAsFactors = F)
Feeds <- which(beren3$event == "bottle")

# Getting summaries of beren3 data
avgMilk <- mean(beren3$value[Feeds])
#tapply() function takes some data (here it is value) and some treatment (here it is age in days) and applies some other function (here is it mean) to those data
avgFeed <- tapply(beren3$value[Feeds], beren3$age[Feeds], mean)
varFeed <- tapply(beren3$value[Feeds], beren3$age[Feeds], var)
totalFeed <- tapply(beren3$value[Feeds], beren3$age[Feeds], sum)
numFeeds <- tapply(beren3$value[Feeds], beren3$age[Feeds], length)

# Finding correlations
#the cor() function tells us the correlation between two sets of numbers (here it is age and amount consumed per day) If you do ?cor you can find different options for different types of corrolations 
cor(beren3$value[Feeds], beren3$age[Feeds])
#cor.test() function works like cor(), but it conducts the appropriate test for the type of correlation you choose (the method argument) and so returns things like a p-value
cor.test(beren3$value[Feeds], beren3$age[Feeds])
berenCor <- cor.test(beren3$value[Feeds], beren3$age[Feeds])
summary(berenCor)

berenANOVA <- aov(beren3$value[Feeds] ~ beren3$caregiver[Feeds])
boxplot(beren3$value[Feeds] ~ beren3$caregiver[Feeds], xlab = "who gave the bottle", ylab = "amount of milk consumed (oz)")

par(las=1, mar=c(5, 5, 1, 1), mgp=c(2, 0.5, 0), tck=-0.01)
plot(as.numeric(names(totalFeed)), totalFeed, type="b", pch=16, xlab="age in days", ylab="ounces of milk")
abline(h=mean(totalFeed), lty=2, col="red")

pdf("r02b-totalMilkByDay.pdf", height = 4, width = 4)
par(las=1, mar=c(5, 5, 1, 1), mgp=c(2, 0.5, 0), tck=-0.01)
plot(as.numeric(names(totalFeed)), totalFeed, type="b", pch=16, xlab="age in days", ylab="ounces of milk")
abline(h=mean(totalFeed), lty=2, col="red")
dev.off()

#Question 2: The graph is impossible to interpret because their is missing data and it very messy. Also the data is only collected at day care and he spend a different amount of time there each day. 

unique(beren3$event)

source("http://jonsmitchell.com/code/plotFxn02b.R")

