setwd("~/Desktop/Evolution/Tasks/Task_04")

#Make our populations 
trueMean1 <- 5
trueSD1 <- 5
population1 <- rnorm(1e6, trueMean1, trueSD1)

trueMean2 <- 4
trueSD2 <- 5
population2 <- rnorm(1e6, trueMean2, trueSD2)

#Now we are taking a sample of each population 
Size <- 50
Sample1 <- sample(population1, Size)
Sample2 <- sample(population2, Size)

#Compare the samples. Are they different? Were the populations different? 
boxplot(Sample1, Sample2)

#Read in the needed functions
source("http://jonsmitchell.com/code/simFxn04.R")

#Use head() and nrow() and such to examine these objects
#The Gradnparents
MatGrandma <- makeFounder("grandma_mom")
MatGrandpa <- makeFounder("grandpa_mom")
PatGrandma <- makeFounder("grandma_da")
PatGrandpa <- makeFounder("grandpa_da")

head(MatGrandma)
head(PatGrandma)
nrow(MatGrandpa)
nrow(PatGrandpa)

#The parental grandparents make Alan (again examine the object)
Alan <- makeBaby(PatGrandma, PatGrandpa)

#Now for Brenda 
Brenda <- makeBaby(MatGrandma, MatGrandpa)

#Brenda and Alan"s first child!
Focus <- makeBaby(Brenda, Alan)

#50%?
#number of genes shared between focus and brenda 
ToMom <- length(grep("mom", Focus)) / length(Focus)

#how many genes the Focus shares with each maternal grandparent 
ToMomMom <- length(grep("grandma_mom", Focus)) / length(Focus)
ToMomDad <- length(grep("grandpa_mom", Focus)) / length(Focus)

head(ToMom)
head(ToMomMom)
head(ToMomDad)
#Paternal Grandparents relatedness 
ToMomMom2 <- length(grep("grandma_da", Focus)) / length(Focus)
ToMomDad2 <- length(grep("grandpa_da", Focus)) / length(Focus)

head(ToMomMom2)
head(ToMomDad2)

#Focus gets a sibling!
Sibling_01 <- makeBaby(Brenda, Alan)

#How much DNA does Focus share with Sibling? 
ToSib <- length(intersect(Focus, Sibling_01)) / length(Focus)

#Brenda and Alan are BUSY? How many genes does Focus share with each of the 1000 siblings? 
ManySiblings <- replicate(1e3, length(intersect(Focus, makeBaby(Brenda, Alan))) / length(Focus))

head(ManySiblings)

#we can summarize data using quantiles and the mean
quantile(ManySiblings)
mean(ManySiblings)

plot(density(ManySiblings), main="", xlab="proportion shared genes")
#Explanation? The plot displays a bell curve and that makes sense because of the quantity of ManySiblings. The larger the number of siblings the more outcomes and range of outcomes. The plot favors a range near 50% shared genes which is common in siblings. 

#IV Hardy Weinburg Equilibrium 
#Given an allele frequency, p, we can calculate the expected genotype frquencies 
HWE <- function(p) {
	aa <- p^2
	ab <- 2 * p * (1-p)
	bb <- (1-p)^2
	return(c(aa=aa, ab=ab, bb=bb))
}
HWE(0.5)

#blank plot
plot(1, 1, type="n", xlim=c(0, 1), ylim=c(0, 1), xlab="freq. allele a", ylab="geno. freq")

#calculated genotypes frequencies for a bunch of alleles frequencies 
p <- seq(from = 0, to = 1, by = 0.01)
GenoFreq <- t(sapply(p,HWE))

#now plot allele frequency p against our expected genotype frequecies (GenoFreq)
lines(p, GenoFreq[, "aa"], lwd=2, col="red")

#WHAT IS GOING ON IN THIS PLOT? 

#Add more genotypes 
lines(p, GenoFreq[, "ab"], lwd=2, col="purple")
lines(p, GenoFreq[, "bb"], lwd=2, col="blue")
legend("top", legend=c("aa", "ab", "bb"), col=c("red", "purple", "blue"), lty=1, lwd=2, bty="n")

#Simulate a Population 
Pop <- simPop(500)

#Add points to HWE plot 
points(Pop[,"freqa"], Pop[,"Genotypes.aa"]/500, pch=21, bg="red")

#Does the frequency of the aa genotype in your population match the expectation from HWE? 

#Smaller Population 
Pop <- simPop(50)
points(Pop[,"freqa"], Pop[,"Genotypes.aa"]/50, pch=22, bg="red")

#V. Two Allele Drift 
library(learnPopGen)

#Ne is how many individuals there are in each population 
#nrep is how many populations you are simulating at once 
x <- genetic.drift(Ne=200, nrep=5, pause=0.01)
x <- genetic.drift(Ne=100, nrep=5, pause=0.01)
x <- genetic.drift(Ne=50, nrep=5, pause=0.01)
x <- genetic.drift(Ne=250, nrep=5, pause=0.01)

#The larger the value of Ne is the more narrow the pattern is in the graph 

#Popualtion Sizes 
PopSizes <- 5:50
#Now there is 5 Populations 
Samples <- rep(PopSizes, 5)

#To fit a line (Linear Model) to data in R you use the lm() function 
Line <- lm(tExt ~ Samples)

#To see fit, use summary()
summary(Line)

#To extract the coeficients, use $coef
Line$coef

#To add it to the plot, use abline()
plot(Samples, tExt)
abline(Line)

Line2 <- lm(tExt~Samples + 0)