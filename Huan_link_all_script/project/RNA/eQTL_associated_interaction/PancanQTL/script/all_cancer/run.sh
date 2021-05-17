perl 01_merge_five_race_1kg.pl 
perl 02_Completion_snp_for_PancanQTL_by_1kg.pl
Rscript 03_NHP_big_par.R
perl 04_filter_hotspot_for_interval18.pl
perl 05_bedtools_cancer_normal_total_share_hotspot.pl # 相同组织，cancer 和 normal -f 1 intersect ，找全部share的hotspot,得my $out1 = "../../output/cancer_total/share/total/${cancer}_contain_${tissue}.bed";my $out2 = "../../output/cancer_total/share/total/${tissue}_contain_${cancer}.bed";
#得汇总文件"../../output/cancer_total/share/total/05_cancer_tissue_intersect_total.bed.gz",

perl 06_bedtools_cancer_normal_all_overlap.pl # 相同组织，cancer 和 normal  intersect, 找全部overlap(为找cancer specifc做铺垫)的hotspot,得my $out1 = "../../output/cancer_total/share/all/${cancer}_contain_${tissue}.bed";
#得汇总文件"../../output/cancer_total/share/all/05_cancer_tissue_intersect_all.bed.gz",

perl 07_filter_cancer_and_normal_specific.pl ##利用../../data/pancanQTL_gtex_eQTL.txt，../../output/cancer_total/share/all/${cancer}_contain_${tissue}.bed，"../../output/${cancer}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${cancer}_segment_hotspot_cutoff_${cutoff}.bed.gz";"../../../GTEx/output/${tissue}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${tissue11}_segment_hotspot_cutoff_${cutoff}.bed.gz" 鉴别组织特异的hotspot"$output_dir/${tissue}_specific.bed.gz"和cancer特异的hotspot  $output_dir/${cancer}_specific.bed.gz,cancer 特异汇总文件为../../output/cancer_total/specific/pure/cancer_specific.bed.gz
