# library(circlize)


# set.seed(999)
# n = 1000
# df = data.frame(factors = sample(letters[1:8], n, replace = TRUE),
#     x = rnorm(n), y = runif(n))

# circos.par("track.height" = 0.1)



library(CMplot)
library(reshape2)
library(stringr)
library(tidyverse)
data <- read.table("/home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/output/test_demo.txt",head=T)
# data <- read.table("../output/test_demo.txt",head=T)
data$SNP <- paste0(data$chr,":",data$t)
data <- data[,c('SNP','emplambda','xQTL')]
data2 <- spread(data,xQTL,emplambda)
head(data2)

Position <- str_extract(data2$SNP,":(.*)")
Position <- gsub(":","",Position)
Chromosome <- str_extract(data2$SNP,"(.*):")
Chromosome <- gsub(":","",Chromosome)

result <- data.frame(data2$SNP,Chromosome,Position,data2[,2:ncol(data2)])
head(result)
CMplot(result,plot.type="c",chr.labels=paste("Chr",c(1:22),sep=""),r=0.4,cir.legend=TRUE,
       outward=FALSE,cir.legend.col="black",cir.chr.h=1,chr.den.col="black",file="jpg",
       memo="",dpi=300,cex= 0.1,file.output=T,verbose=TRUE,ylim=0.75)