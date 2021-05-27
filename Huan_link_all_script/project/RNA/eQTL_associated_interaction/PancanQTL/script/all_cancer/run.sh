perl 01_merge_five_race_1kg.pl 
perl 02_Completion_snp_for_PancanQTL_by_1kg.pl
Rscript 03_NHP_big_par.R
perl 04_filter_hotspot_for_interval18.pl
perl 05_bedtools_cancer_normal_total_share_hotspot.pl # # 相同组织，cancer 和 normal -f 1 intersect ，找全部share的hotspot,得my $out1 = "../../output/cancer_total/share/total/${cancer}_contain_${tissue}.bed";my $out2 = "../../output/cancer_total/share/total/${tissue}_contain_${cancer}.bed";
#得汇总文件"../../output/cancer_total/share/total/05_cancer_tissue_intersect_total.bed.gz", cancer 被完全包含的文件"../../output/cancer_total/share/total/05_cancer_share_total.bed.gz"

perl 06_bedtools_cancer_normal_all_overlap.pl # 相同组织，cancer 和 normal  intersect, 找全部overlap(为找cancer specifc做铺垫)的hotspot,得my $out1 = "../../output/cancer_total/share/all/${cancer}_contain_${tissue}.bed";
#得汇总文件"../../output/cancer_total/share/all/05_cancer_tissue_intersect_all.bed.gz",

perl 07_filter_cancer_and_normal_specific.pl #利用../../data/pancanQTL_gtex_eQTL.txt，../../output/cancer_total/share/all/${cancer}_contain_${tissue}.bed，"../../output/${cancer}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${cancer}_segment_hotspot_cutoff_${cutoff}.bed.gz";"../../../GTEx/output/${tissue}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${tissue11}_segment_hotspot_cutoff_${cutoff}.bed.gz" 鉴别组织特异的hotspot"$output_dir/tissue_${cancer}_${tissue}_specific.bed.gz"和cancer特异的hotspot  $output_dir/cancer_${cancer}_${tissue}_specific.bed.gz,cancer 特异汇总文件为../../output/cancer_total/specific/pure/cancer_specific.bed.gz，tissue特异汇总文件../../output/cancer_total/specific/pure/tissue_specific.bed.gz
perl 08_count_cancer_all_and_specific_hotspot.pl #得"../../output/cancer_total/08_number_of_cancer_all_hotspot.txt.gz"，"../../output/cancer_total/08_number_of_cancer_specific_hotspot.txt.gz"

perl 09_count_cancer_related_tissue_specific_hotspot.pl #"../../output/cancer_total/specific/pure/09_count_cancer_related_specific_hotspot.txt.gz"

Rscript 10_bar_plot_cancer_tissue_specific_and_all_hotspot.R

perl 11_count_cancer_tissue_share_hotspot.pl 
Rscript 11_cancer_tissue_share_hotspot.R
Rscript 12_barplot_Cleveland_distbution_of_hotspot_in_share_tissues.R 
Rscript 13_Cleveland_dot_plot.R

perl 14_find_gene_affected_by_cancer_specific_hotspot.pl  





