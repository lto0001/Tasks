install.packages("paleobioDB", dep=T)
setwd("~/Desktop/Evolution/Tasks/Task_03")
library(paleobioDB)

#Download data from specific taxon "Dinosauria"
Taxon <- "Dinosauria"

#min_ma and max_ma arguements control the time-window that you are pulling fossils from in millions of years 
MinMA <- 66
MaxMA <- 252
fossils <- pbdb_occurrences(base_name = Taxon, show = c("phylo", "coords", "ident"), min_ma=MinMA, max_ma=MaxMA)

#III Analyzing Data: Through Time 
#how many species are known from each time period?
#we will define a time period Resolution (Res) of 5Ma
Res <- 5
nspeciesOverTime <- pbdb_richness(fossils, rank = "genus", temporal_extent = c(MaxMA,MinMA), res=Res)

#default plat alternative 
par(mar=c(4, 5, 2, 1), las=1, tck=-0.01, mgp=c(2.5, 0.5, 0))
#shows the raw number of known species of dinosaurs changes over time 
plot(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime)), nspeciesOverTime[,2], xlim=c(MaxMA, MinMA), type="l", xlab="age (millions of years ago)", ylab="num. of species", main = Taxon)


newspeciesOverTime <- pbdb_orig_ext(fossils, res=5, rank="species", temporal_extent=c(MinMA, MaxMA))
#set up plot
par(mar=c(4, 5, 2, 1), las=1, tck=-0.01, mgp=c(2.5, 0.5, 0))
#plot first appearance 
plot(seq(to=MaxMA, from=MinMA, length.out=nrow(newspeciesOverTime)), newspeciesOverTime[,1], xlim=c(MaxMA, MinMA), type="l", xlab="age (millions of years ago)", ylab="num. of species", main = Taxon)
#add a line for last appearance 
lines(seq(to=MaxMA, from=MinMA, length.out=nrow(newspeciesOverTime)), newspeciesOverTime[,2], col="red")

legend("topleft", legend=c("first appear", "go extinct"), col=c("black", "red"), lty=1, bty="n")

#IV. Analyzing Data: Through Space 
OceanCol <- "light blue"
LandCol <- "black"

Cols <- c('#fee5d9', '#fcae91', '#fb6a4a', '#de2d26', '#a50f15')
#make map
par(las=0)
pbdb_map_richness(fossils, col.ocean=OceanCol, col.int=LandCol, col.rich=Cols)

#V. Analyzing Data: Through Space and Time 
#https://www.geosociety.org/documents/gsa/timescale/timescl.pdf

#Trassic Fossils
MinMA <- 201
MaxMA <- 252
triassic_fossils <- pbdb_occurrences(base_name = Taxon, show = c("phylo", "coords", "ident"), min_ma=MinMA, max_ma=MaxMA)

#Jurassic Fossils 
MinMA <- 145
MaxMA <- 201
jurassic_fossils <- pbdb_occurrences(base_name = Taxon, show = c("phylo", "coords", "ident"), min_ma=MinMA, max_ma=MaxMA)

#Cretaceous Fossils 
MinMA <- 66
MaxMA <- 145
cretaceous_fossils <- pbdb_occurrences(base_name = Taxon, show = c("phylo", "coords", "ident"), min_ma=MinMA, max_ma=MaxMA)

#make into maps 
#Trassic Map
dev.new(height = 7.8, width = 13)
pbdb_map_richness(triassic_fossils, col.ocean=OceanCol, col.int=LandCol, col.rich=Cols)
mtext(side=3, "Triassic (252-201Ma)", cex=3, line=-2)

#Jurassic Map
dev.new(height = 7.8, width = 13)
pbdb_map_richness(jurassic_fossils, col.ocean=OceanCol, col.int=LandCol, col.rich=Cols)
mtext(side=3, "Jurassic (201-145Ma)", cex=3, line=-2)

#Cretaceous Map
dev.new(height = 7.8, width = 13)
pbdb_map_richness(cretaceous_fossils, col.ocean=OceanCol, col.int=LandCol, col.rich=Cols)
mtext(side=3, "Cretaceous (145-66Ma)", cex=3, line=-2)


#VI. Analyzing Data:Comparing with Another Group 
Taxon2 <- "Mammalia"
MinMA <- 66
MaxMA <- 252
fossils2 <- pbdb_occurrences(base_name = Taxon2, show = c("phylo", "coords", "ident"), min_ma=MinMA, max_ma=MaxMA)

nspeciesOverTime2 <- pbdb_richness(fossils2, rank = "genus", temporal_extent = c(MaxMA, MinMA), res=Res)

#Plotting both groups together 
par(mar=c(4, 5, 2, 1), las=1, tck=-0.01, mgp=c(2.5, 0.5, 0))
Col_dino <- Cols[length(Cols)]
Col_mammal <- Cols[1]
LineWidth <- 2
plot(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime)), nspeciesOverTime[,2], xlim=c(MaxMA, MinMA), type="l", xlab="age (millions of years ago)", ylab="num. of species", col=Col_dino, lwd=LineWidth)
lines(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime2)), nspeciesOverTime2[,2], col=Col_mammal, lwd=LineWidth)
legend("topleft", legend=c(Taxon, Taxon2), col=c(Col_dino, Col_mammal), bty="n", lwd=LineWidth)

#VII. Extention 
Taxon3 <- "Bivalvia"
MinMA <- 500
MaxMA <- 540
fossils3 <- pbdb_occurrences(base_name = Taxon3, show = c("phylo", "coords", "ident"), min_ma=MinMA, max_ma=MaxMA)
nspeciesOverTime3 <- pbdb_richness(fossils3, rank = "genus", temporal_extent = c(MaxMA, MinMA), res=Res)


Taxon4 <- "Echinodermata"
MinMA <- 500
MaxMA <- 540
fossils4 <- pbdb_occurrences(base_name = Taxon4, show = c("phylo", "coords", "ident"), min_ma=MinMA, max_ma=MaxMA)
nspeciesOverTime4 <- pbdb_richness(fossils4, rank = "genus", temporal_extent = c(MaxMA, MinMA), res=Res)

#Both groups together 
par(mar=c(4, 5, 2, 1), las=1, tck=-0.01, mgp=c(2.5, 0.5, 0))
Col_bivalve <- Cols[length(Cols)]
Col_echinoderm <- Cols[1]
LineWidth <- 2

plot(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime3)), nspeciesOverTime3[,2], xlim=c(MaxMA, MinMA), type="l", xlab="age (millions of years ago)", ylab="num. of species", col=Col_bivalve, lwd=LineWidth)

lines(seq(to=MaxMA, from=MinMA, length.out=nrow(nspeciesOverTime4)), nspeciesOverTime4[,2], col=Col_echinoderm, lwd=LineWidth)

legend("topleft", legend=c(Taxon3, Taxon4), col=c(Col_bivalve, Col_echinoderm), bty="n", lwd=LineWidth)
