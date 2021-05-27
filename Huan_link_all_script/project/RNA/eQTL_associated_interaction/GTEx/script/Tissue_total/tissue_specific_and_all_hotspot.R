library(ggplot2)
library(dplyr)
library(Rcpp)
library(readxl)
library(stringr)
library(gcookbook)
library(gridExtra)
library(ggpubr)
library(tidyverse)

p_theme<-theme(panel.grid =element_blank())+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
                                                panel.background = element_blank(), axis.title.y = element_text(size = 10),
                                                axis.title.x = element_text(size = 10),
                                                axis.line = element_line(colour = "black"))
#-------------------------------------------------------
setwd("/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_total/")

all_hotspot <- read.table("number_of_tissue_all_hotspot.txt.gz",header = T,sep = "\t") %>% as.data.frame()
tissue_specific_hotspot <- read.table("number_of_tissue_specific_hotspot.txt.gz",header = T,sep = "\t") %>% as.data.frame()


all_data<-inner_join(all_hotspot,tissue_specific_hotspot,by="Tissue")
all_data$diff <- all_data$Number.x - all_data$Number.y
diff <-all_data%>%dplyr::select(-c(2,3))
colnames(diff)[2] <-"Number"

tissue_specific_hotspot$Class <- "Specific"
diff$Class <- "All"
final <-bind_rows(tissue_specific_hotspot,diff)
final$Tissue<-factor(final$Tissue,levels= sort(diff$Tissue,decreasing = T))
pdf("tissue_specific_and_all_tissue.pdf")
p1 <-ggplot(final,aes(x=Tissue,y=Number,fill=Class))+geom_bar(stat='identity',width=0.5 )+scale_fill_manual(values=c("#f29191","#1eae98"))+p_theme+xlab("Tissue") +ylab("Number of hotspots") +coord_flip()+
    theme(axis.text.y = element_text(color="black"),axis.text.x = element_text(color="black"))
print(p1)   
dev.off()

# p1 <-ggplot(final,aes(x=Tissue,y=Number,fill=Class))+geom_bar(stat='identity',width=0.5 )+scale_fill_manual(values=c("#a6d6d6","#6f9eaf"))+p_theme+xlab("Tissue") +ylab("Number of hotspots") +coord_flip() 
# print(p1)   
# dev.off()

# p1 <-ggplot(final,aes(x=Tissue,y=Number,fill=Class))+geom_bar(stat='identity',width=0.5 )+p_theme+xlab("Tissue") +ylab("Number of hotspots") +coord_flip() 
# print(p1)   
# dev.off()   
    


# color = "#5f939a"
# # pdf("barplot_distbution_of_hotspot_in_share_tissues.pdf",height = 3.5,width = 3.8)
# p1 <-ggplot(all_hotspot,mapping=aes(x=Tissue,y=Number))+geom_bar(stat='identity',colour=color,fill =color,width=0.5 )+
#     p_theme+xlab("Number of share tissue") +ylab("Number of hotspots")+coord_flip()
# color2 = "#bbbbbb"
# p2 <-ggplot(tissue_specific_hotspot,mapping=aes(x=Tissue,y=Number))+geom_bar(stat='identity',colour=color2,fill =color2,width=0.5 )+
#     p_theme+xlab("Number of share tissue") +ylab("Number of hotspots")+coord_flip()
# # print(p2)
# p3 <-p1+p2
# print(p3)
# dev.off()

