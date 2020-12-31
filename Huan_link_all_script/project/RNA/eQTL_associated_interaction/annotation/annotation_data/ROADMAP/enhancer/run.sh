perl 01_normal.pl #对"E062-H3K27ac.narrowPeak.gz","E062-H3K4me1.narrowPeak.gz" 进行normal和排序得${fo1}sorted.gz
# bedtools intersect -F 0.1 -a 01_normal_E062-H3K4me1.narrowPeaksorted.gz -b 01_normal_E062-H3K27ac.narrowPeaksorted.gz -wo |gzip  > 01_normal_E062-H3K4me1_H3K27ac.narrowPeaksorted.gz
bedtools intersect -F 0.1 -a 01_normal_E062-H3K4me1.narrowPeaksorted.gz -b 01_normal_E062-H3K27ac.narrowPeaksorted.gz  |sort -k1,1 -k2,2n | gzip  > 01_normal_E062-H3K4me1_H3K27ac.narrowPeaksorted_overlap.gz
bedtools  complement -i 01_normal_E062-H3K4me1_H3K27ac.narrowPeaksorted_overlap.gz -g /home/huanhuan/ref_data/UCSC/hg19.chrom1_22_sizes_sorted.txt | gzip> 01_enhancer_complement.bed.gz

cp 01_normal_E062-H3K4me1_H3K27ac.narrowPeaksorted_overlap.gz /home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/enhancer.bed.gz
cp 01_enhancer_complement.bed.gz /home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/non_enhancer.bed.gz