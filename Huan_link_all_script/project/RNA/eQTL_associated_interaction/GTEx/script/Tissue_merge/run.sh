perl 01_merge_all_tissue_eQTL.pl #
Rscript 02_NHP_big_par.R
perl 03_filter_hotspot_for_interval18.pl
perl 04_extend_hotspot.pl #用"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/NHP/NHPoisson_emplambda_interval_18_cutoff_7.3_Tissue_merge.txt.gz"对"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176.bed.gz"左边扩9个SNP，右边扩8个SNP得"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend.bed.gz",对其进行排序得"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted.bed.gz"

bedtools merge -i "/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted.bed.gz" |gzip >"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz"



Rscript 04_circos_density.R
mv *.pdf ./figure
Rscript 05_find_chr1_max_density.R 
perl 06_merge_merge_hotspot_and_egene.pl 


