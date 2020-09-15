library(gcookbook)
library(dplyr)
library(ggplot2)
library(readr)
library(data.table)
library(stringr)


setwd("/home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/output/ALL_eQTL/")
org1<-fread("QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_all_cis_trans_eQTL_normalized_sorted.bed.gz",header = F,sep = "\t") %>% as.data.frame()
colnames(org1)[1]<-"chr"
colnames(org1)[2]<-"start"
colnames(org1)[3]<-"end"
colnames(org1)[4]<-"pos"
colnames(org1)[5]<-"emplambda"
org1$key <-paste(org1$chr,org1$start,sep = ":")
tmp<-org1
setwd("/home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/relevant/output/annotation")

files<- list.files("~/project/RNA/eQTL_associated_interaction/QTLbase/relevant/output/annotation","bed.gz")
# files<-c(files[1],files[2])
for (file in files){
    name <- str_replace(file,"QTLbase_all_eQTL_","")  #replace
    name <- str_replace(name,".bed.gz","")  #replace
    name <- str_replace(name,"_narrow_peak","")  #replace
    print(name)
    if (name != "hic_loops_1" && name != "hic_loops_2" && name !="phastCons100way" ){
        print("klk")
        org2<-fread(file,header = F,sep = "\t") %>% as.data.frame()
        org2$name <-paste(org2$V6,org2$V7,org2$V8,sep=":")
        colnames(org2)[9]<-name
        org2$key <-paste(org2$V1,org2$V2)
        org2<-org2[,-c(1:8)] #删除前8列
        tmp <-left_join(tmp,org2,by = "key")
    } else if(name == "hic_loops_1" || name == "hic_loops_2" ){
        org2<-fread(file,header = F,sep = "\t") %>% as.data.frame()
        org2$name <-paste(org2$V6,org2$V7,org2$V8,org2$V12,sep=":")
        colnames(org2)[9]<-name
        org2$key <-paste(org2$V1,org2$V2)
        org2<-org2[,-c(1:12)] #删除前12列
        tmp <-left_join(tmp,org2,by = "key")
    }else{
        org2<-fread(file,header = F,sep = "\t") %>% as.data.frame()
        colnames(org2)[9]<-"conservation"
        org2$key <-paste(org2$V1,org2$V2)
        org2<-org2[,-c(1:8)]
        tmp <-left_join(tmp,org2,by = "key")
    }
}

