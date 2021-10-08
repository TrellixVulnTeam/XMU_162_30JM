perl 01_merge_all_tissue_eQTL.pl #
Rscript 02_NHP_big_par.R
perl 03_filter_hotspot_for_interval18.pl
perl 04_extend_hotspot.pl #用"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/NHP/NHPoisson_emplambda_interval_18_cutoff_7.3_Tissue_merge.txt.gz"对"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176.bed.gz"左边扩9个SNP，右边扩8个SNP得"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend.bed.gz",对其进行排序得"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted.bed.gz"
bedtools merge -i "/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted.bed.gz" |gzip >"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz"
Rscript 041_plot_distribution_the_length_of_hotspot.R
Rscript 042_circos_density.R
#-----------------------------------------
perl 06_merge_merge_hotspot_and_egene.pl 
perl 07_annotation_markers.pl

Rscript 071_heatmap_annotation.R
perl 072_count_anno_histone_mark.pl
perl 073_calculate_jaccard_index_mark.pl #对 $input_dir/${mark}_Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz 计算 jaccard index得$out_dir/${group}_cutoff_${cutoff}_marker_jaccard_index.txt.gz
#---------------------------------

perl 08_transform_kmer_result_all.pl
 
#-----------


Rscript 04_circos_density.R
mv *.pdf ./figure
Rscript 05_find_chr1_max_density.R 
perl 06_merge_merge_hotspot_and_egene.pl 


