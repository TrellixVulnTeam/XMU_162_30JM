wget -c http://www.noncode.org/datadownload/NONCODEv5_hg19.lncAndGene.bed.gz
perl 01_normalized.pl #将NONCODEv5_hg19.lncAndGene.bed.gz中需要的列提出来，得NONCODEv5_hg19.lncAndGene_need.bed.gz
zless NONCODEv5_hg19.lncAndGene_need.bed.gz | sort -k1,1 -k2,2n | gzip >NONCODEv5_hg19.lncAndGene_sorted.bed.gz