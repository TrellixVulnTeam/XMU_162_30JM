library(ggplot2)
library(Rcpp)
library(readxl)
library(dplyr)
library(stringr)
library(ggpubr)
library(gridExtra)
library(ggpval)
library(Seurat)
library(reshape2)

setwd("/share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/kmer/ALL/")
org<-read.csv("6mers_uc_us_no_log.csv.gz",header = T,sep = ",") %>% as.data.frame()
colnames(org)[1] <-"hotspot"
org2 <-melt(org,"hotspot")
colnames(org2)[2] <-"seq"

sig_hotspot <-filter(org2, value>0)


seq_count <- sig_hotspot%>%group_by(seq)%>%summarise(count=n())%>%as.data.frame()
seq_count$ratio <-seq_count$count/nrow(org)



p_theme<-theme(panel.grid =element_blank())+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
                                                panel.background = element_blank(), axis.title.y = element_text(size = 8),
                                                # axis.title.x = element_text(size = 10),
                                                axis.line = element_line(colour = "black"))


setwd("/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/script/Whole_blood/kmer/")

#----------------------------point plot
pdf("./figure/Kmer_occur_count.pdf",width=3.2, height=3)

p1 <-ggplot(seq_count,mapping = aes(x=seq ,y = count))+geom_point(size=0.1) +ylab("Count")+ 
    theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+xlab("Kmer")+p_theme
print(p1)
dev.off()

pdf("./figure/Kmer_occur_ratio.pdf",width=3, height=3)
p2 <-ggplot(seq_count,mapping = aes(x=seq ,y = ratio))+geom_point(size=0.1) +ylab("Ratio")+ 
    theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+xlab("Kmer") +p_theme

print(p2)
dev.off()

#------------summary boxplot
pdf("./figure/Kmer_occur_boxplot_ratio.pdf",width=3.5, height=3.5)
p<-ggplot(seq_count,aes(x=1, y=ratio))+geom_violin(fill="#a3d2ca",width=0.65)+geom_boxplot(fill = "#5eaaa8",width=0.2)+ theme(legend.position ="none")+p_theme+theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+xlab("Kmer")+ylab("Ratio")

print(p)
dev.off()

#---------all boxplot
png("./figure/Kmer_count_boxplot_without_outlier.png")
p<-ggplot(org2,aes(x=seq, y=value))+geom_boxplot(aes(fill = seq),outlier.colour = NA)+ theme(legend.position ="none")+p_theme+theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+xlab("Kmer")+ylab("kmer count")

print(p)
dev.off()


pdf("./figure/Kmer_count_boxplot_without_outlier.pdf",width=3.5, height=3.5)
p<-ggplot(org2,aes(x=seq, y=value))+geom_boxplot(aes(fill = seq),outlier.colour = NA)+ theme(legend.position ="none")+p_theme+theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+xlab("Kmer")+ylab("kmer count")

print(p)
dev.off()

#-------------------


rs <-data.frame()

cutoffs<-seq(0,0.25,0.01)

for(cutoff in cutoffs){
    aa <-filter(seq_count,ratio >cutoff)
    kmer_ratio =nrow(aa)/(4^6)
    kmer_count = nrow(aa)
    tmp <-data.frame(hotspot_ratio =cutoff,kmer_ratio = kmer_ratio,kmer_count=kmer_count)
    rs<-bind_rows(rs,tmp)
    print(cutoff)
}


pdf("./figure/hit_hotspot_ratio_Kmer_ratio.pdf",width=3.2, height=3)

p1 <-ggplot(rs,mapping = aes(x=hotspot_ratio ,y = kmer_ratio))+geom_point(size=0.1) +ylab("Kmer ratio")+ 
    xlab("Hit hotspot ratio")+p_theme
print(p1)
dev.off()
#-------------------
pdf("./figure/hit_hotspot_ratio_Kmer_count.pdf",width=3.2, height=3)

p1 <-ggplot(rs,mapping = aes(x=hotspot_ratio ,y = kmer_count))+geom_point(size=0.1) +ylab("Kmer count")+ 
    xlab("Hit hotspot ratio")+p_theme
print(p1)
dev.off()
