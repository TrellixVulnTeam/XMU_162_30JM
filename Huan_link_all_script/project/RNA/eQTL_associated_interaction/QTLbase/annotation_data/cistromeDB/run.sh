# the peak calling is from the https://hbctraining.github.io/Intro-to-ChIPseq/lessons/05_peak_calling_macs.html
# the file header is following the picture
perl 01_merge.pl #将./Human_FACTOR/human_factor, ./HISTONE_MARK_AND_VARIANT/human_hm, ./Human_CHROMATIN_Accessibility/human_ca下的文件merge到一起"${output_dir}/merge_pos_info_sample_narrow_peak.bed.gz"
