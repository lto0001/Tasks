setwd("~/Desktop/Evolution/Tasks/Task_06")
install.packages("learnPopGen")
library(learnPopGen)
coalescent.plot()

#Questions
#1 How many alleles does each simulation begin with? How do you modify that?
# They start with 2-3 alleles, use a function to change the amount of alleles in a generation. 
#2 On average, how many generations does it take for one allele to go to fixation?
# I am guessing 3 
#3 What's the average number of offspring each haploid individual has? What's the variance in that number? 
#4 What role does fitness play in these simulations?
#5 Is the most recent common ancester for the focal locus typically alive in generation 0? 

install.packages("coala")
library(coala)
install.packages("phytools")
library(phytools)

#Setting up the model... 5 individual and 1 pop
model <- coal_model(sample_size = 5, loci_number = 10, loci_length = 500, ploidy = 2) + feat_mutation(10) + feat_recombination(10) + sumstat_trees() + sumstat_nucleotide_div()

stats <- simulate(model, nsim = 1)

#Each locus has a measure of genetic diversity called "pi". pi is a standard measure. It's the average number of differences at a locus between any two individuals 
Diversity <- stats$pi
#The numbers are not the same, but I do not know why 

Nloci <- length(stats$trees)

#First SNP for first locus 
t1 <- read.tree(text=stats$trees[[1]][1])

plot(t1)
axisPhylo()

#Question 6: why does the number of tips NOT match the number of individuals you simulated? 

#Age of the most recent ancester for the SMP 
Agel <- max(nodeHeights(t1))

#first SNP second locus 
t2 <- read.tree(text=stats$trees[[2]][1])

plot(t2)
axisPhylo()
#how far back is the most recent common ancester for this SNP? Is it the same age as for the first SNP? 

#Question 7: Do they match? Let's plot them next to each other. 
#No they do not match 

par(mfrow=c(1,2))
plot(t1)
axisPhylo()
plot(t2)
axisPhylo()

compare.chronograms(t1, t2)

t1_1 <- read.tree(text=stats$trees[[1]][1])
t1_2 <- read.tree(text=stats$trees[[1]][2])
compare.chronograms(t1_1, t1_2)

#DO NOT MOVE ON UNTIL YOU UNDERSTAND THE ABOVE 

for(locus in 1:Nloci) {
	ntrees <- length(stats$trees[[locus]])
	for(n in 1:ntrees) {
		if(locus == 1 && n == 1) {
			outPhy <- read.tree(text=stats$trees[[locus]][n])
		}
		else {
			outPhy <- ape:::c.phylo(outPhy, read.tree(text=stats$trees[[locus]][n]))
		}
	}
}

par(mfrow=c(1,1))
densityTree(outPhy)

#Study opprotunity!
#1. Look at this set of trees.
#2. Go up and change ONE thing about the model (e.g. recombination rate)
#3. Predict, based on what you changed in the model, how this final plot will be different. 
#4. Rerun the model & this code. Is it different in the way you predicted? 


model3 <- coal_model(10, 50) + feat_mutation(par_prior("theta", sample.int(100, 1))) + sumstat_nucleotide_div()

stats <- simulate(model3, nsim = 40)
mean_pi <- sapply(stats, function(x) mean(x$pi))
theta <- sapply(stats, function(x) x$pars[["theta"]])


par(mfrow=c(1,1))
plot(mean_pi)
axisPhylo()
plot(theta)
axisPhylo()
