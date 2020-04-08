setwd("~/Desktop/Evolution/Tasks/Task_09")

library(phytools)

tree <- read.tree(text="(((A,B) ,(C,D)) ,E) ;")

plot(tree, type="fan")
#Question #1: How many tips are there in the tree, and are branch lengths present? 5 tips and no

data <- read.csv("https://jonsmitchell.com/data/svl.csv", stringsAsFactors=F, names=1)
#Question #2: What kind of object is "data"? What are its dimensions? 

#converting the object data into a vector 
svl <- setNames(data$svl, rownames(data))

Ancestors <- fastAnc(tree, svl, vars=TRUE, CI=TRUE)

#Examime the Ancestors object and the help file for fastAnc
#Question #3: Where are the estimated values stored? What is the CI95 element?
#Question #4: What are two assumptions made in the estimation of the ancestral states using fastAnc? 

par(mar=c(0.1, 0.1, 0.1, 0.1))
plot(tree, type="fan", lwd=2, show.tip.label=F)

tiplabels(pch=16, cex=0.25*svl[tree$tip.label])

nodelabels(pch=16, cex=0.25*Ancestors$ace)

obj <- contMap(tree,svl, plot=F)
