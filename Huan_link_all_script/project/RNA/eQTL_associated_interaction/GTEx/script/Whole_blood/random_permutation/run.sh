perl 32_random_genomic_resemble_hotspot.pl  ##产生1000个与../../../output/${tissue}/Cis_eQTL/${group}_cis_eQTL/interval_18/whole_blood_segment_${group}_cutoff_${cutoff}.bed.gz相同的resemble hotspot,"$output_dir/${i}_resemble_${input_file_base_name}",
perl 33_random_permutation_hotspot.pl # 对 resemble hotspot,"$output_dir/${i}_resemble_${input_file_base_name} 和../../../output/${tissue}/Cis_eQTL/${group}_cis_eQTL/interval_18/whole_blood_segment_${group}_cutoff_${cutoff}.bed.gz 进行 random_permutation，得得../../../output/${tissue}/Cis_eQTL/${group}_cis_eQTL/interval_18_random/random_permutation/${cutoff}/${i}_resemble_${tissue}_segment_${group}_cutoff_${cutoff}.bed.gz
perl 34_annotation_chrom_state_original_random_and_permutation_hotspot.pl #对1000个original_random和random_permutation进行chromatin_states的注释，得../../../output/${tissue}/Cis_eQTL/annotation/interval_18/ALL/${group}/${cutoff}/${type}/${i}_25_state_resemble_${input_file_base_name}
perl 35_filter_annotation_chrom_state.pl #因为每个片段会被多个chrom state 注释，根据对hotspot的覆盖比例，选出覆盖比例最高的state, interval_18 时，对"../../../output/${tissue}/Cis_eQTL/annotation/interval_18/ALL/${group}/${cutoff}/${type}/${state}_state_resemble_${i}_resemble_${tissue}_segment_${group}_cutoff_${cutoff}.bed.gz"进行过滤，得$dir/filter_$name
perl 36_count_per_state_number.pl ##对"$dir/filter_$name"中的chromatin state 进行统计，得"../../../output/${tissue}/Cis_eQTL/enrichment/interval_18/ALL/${type}_${state}_state_count_${tissue}_cutoff_${cutoff}.txt"
#-------------------
mv /home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Whole_Blood/Cis_eQTL/annotation/interval_18/ALL/hotspot/0.176/random_permutation  /share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/interval_18/annotation/ALL/hotspot/0.176/
mv /home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Whole_Blood/Cis_eQTL/annotation/interval_18/ALL/hotspot/0.176/original_random  /share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/interval_18/annotation/ALL/hotspot/0.176/

Rsript 37_boxplot_plot_compare_hotspot_and_background_15state.R 
perl 38_transform_36.pl 
Rsript 39_boxplot_plot_compare_hotspot_and_background_25state.R 

