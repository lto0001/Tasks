setwd("~/Desktop/Evolution/Tasks/Task_08")

library(phytools)
library(ape)

#Imputting a Tree and plotting it
text.string <- "(((((((cow, pig), whale),(bat, (lemur, human))), (robin, iguana)), coelacanth), (gold_fish, trout)), shark) ;"
vert.tree <- read.tree(text=text.string)
plot(vert.tree, edge.width=2)

#number of nodes that separate the two linages reflects how distantly related they are 
nodelabels(frame="circle", bg="white", cex=1)

#Question 1: What's more closely related to the gold fish, a shark or a human? 
#Gold fish is more closely related to a human than a shark. A human and a goldfish are descended from node 14, while sharks and goldfish are descended from node 13. 

#looking at the object 
vert.tree

#Question 2: Are there branch lengths in this tree? 
#No branch length in this tree

str(vert.tree)

#Digging into the phylo object with another simpler tree
tree <- read.tree(text="(((A,B) ,(C,D)) ,E) ;")
plotTree(tree, offset=1)
tiplabels(frame="circle", bg="lightblue", cex=1)
nodelabels(frame="circle", bg="white", cex=1)

#we can call each tip using
tree$tip.label

#what's the edge matrix? Read on!
#we can look into the phylo object's edge component, we can see the structure of the phylogeny as a matrix 
tree$edge 

#each line on the phylogeny is called an "edge". So each row of tree$edge corresponds to one of the lines (edges) of the phylogeny. The first number is where the line starts, the second number is where the line ends. So the first row shows the first line starts at number 6 and goes to number 7.

#now we are using a real phylogeny of Anolis Lizards
AnolisTree <- force.ultrametric(read.tree("https://jonsmitchell.com/data/anolis.tre"))

par(las=1)
hist(AnolisTree$edge.length, col="black", border="white", main="", xlab="edge length for the Anolis Tree", ylim=c(0, 50), xlim=c(0, 6))

tipEdges <- which(AnolisTree$edge[,2] <= Ntip(AnolisTree))
Lengths <- AnolisTree$edge.length
names(Lengths) <- AnolisTree$tip.label
names(Lengths)[which(Lengths == min(Lengths))]

plot(AnolisTree, cex=0.25)
Labs <- sapply(AnolisTree$edge.length, round, digits=2)
edgelabels(text=Labs, cex=0.25)

#each edge has a length, and they're in order. So the first value of edge length is the length of the edge defined by the first row of the edge matrix. 

?plot.phylo

#Question 3: a tree with no tip labels 

plot(tree, type = "phylogram", use.edge.length = TRUE, node.pos = NULL, show.node.label = FALSE, edge.color = "black", edge.width = 1, edge.lty = 1, font = 3, cex = par("cex"))

#Question 4: A tree that is plotted as a circle, instead of facing right or left.

plot(tree, type = "phylogram", use.edge.length = TRUE, node.pos = NULL, show.tip.label = TRUE, show.node.label = FALSE, edge.color = "black", edge.width = 1, edge.lty = 1, font = 3, cex = par("cex"), rotate.tree = 360)

#Question 5: A tree with the tips colored red instead of black 

plot(tree, type = "phylogram", use.edge.length = TRUE, node.pos = NULL, show.tip.label = TRUE, show.node.label = FALSE, edge.color = "black", edge.width = 1, edge.lty = 1, font = 3, cex = par("cex"), tip.color = "red")

#Question 6-8: Find 1) which living, named species has the shortest egde length (NOT necessarily the shortes overall length!), then 2) drop that tip from the tree, then 3) plot the resulting tree. 
#use the which() function 

#how fast species appearred in this phylogeny by making a lineage-through-time (ltt) plot. it will show the number of observed lineages alive at any given time 

ltt(AnolisTree)
abline(0, 1, lwd=2, col="red", lty=2)
#a phylogenic tree with 82 tips and 81 internal nodes 
#vectors containing the number of lineages (ltt) and branching times (times) on the tree
#a value for pybus & harvey's "gamma" statistics of -4.5623, p-value = 0

#Question 10: Use the function fit.bd() to calculate the rate new species form (b) and disappear (d) in Anolis lizards. Set rho = 0.2

?fit.bd()
fit.bd(AnolisTree, b=NULL, d=NULL, rho = 0.2)

#EXTRA CREDIT: 

install.packages("treebase")
library(treebase)
?treebase

cache_treebase(warblers)
cache_treebase(Parulidae)
warblers <- search_treebase("Parulidae", by="taxon")