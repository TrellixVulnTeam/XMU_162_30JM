perl 01_normal.pl  ##对"E062-H3K4me3.narrowPeak.gz 进行normal和排序得${fo1}sorted.gz
bedtools complement -i 01_normal_E062-H3K4me3.narrowPeaksorted.gz -g /home/huanhuan/ref_data/UCSC/hg19.chrom1_22_sizes_sorted.txt | gzip> 01_promoter_complement.bed.gz
cp 01_normal_E062-H3K4me3.narrowPeaksorted.gz /home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/promoter.bed.gz
cp 01_promoter_complement.bed.gz /home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/non_promoter.bed.gz