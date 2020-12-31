# the peak calling is from the https://hbctraining.github.io/Intro-to-ChIPseq/lessons/05_peak_calling_macs.html
# the file header is following the picture
perl 01_merge.pl #将./Human_FACTOR/human_factor, ./HISTONE_MARK_AND_VARIANT/human_hm, ./Human_CHROMATIN_Accessibility/human_ca下的文件merge到一起"${output_dir}/merge_pos_info_sample_narrow_peak.bed.gz"


perl 03_filter_chr1_22.pl
#过滤出${output_dir}/merge_pos_info_narrow_peak_sorted.bed.gz中的chr1_22,得${output_dir}/03_merge_pos_info_narrow_peak_sorted_chr1_22.bed.gz
#将${output_dir}/03_merge_pos_info_narrow_peak_sorted_chr1_22.bed.gz左右各扩500bp得${output_dir}/03_merge_pos_info_narrow_peak_sorted_chr1_22_extend_500bp.bed.gz
#将${output_dir}/03_merge_pos_info_narrow_peak_sorted_chr1_22.bed.gz左右各扩100bp得${output_dir}/03_merge_pos_info_narrow_peak_sorted_chr1_22_extend_100bp.bed.gz