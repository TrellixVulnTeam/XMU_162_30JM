# bedtools intersect  -f 0.1 -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/chromatin_states/25_state_12_mark/${roadmap_biospecimen}_25_imputed12marks_mnemonics.bed.gz" -wa -wb | gzip > $output_dir/25_state_$input_file_base_name
# bedtools intersect -f 0.1 -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/chromatin_states/15_state_5_mark/${roadmap_biospecimen}_15_coreMarks_mnemonics.bed.gz" -wa -wb | gzip > $output_dir/15_state_$input_file_base_name


bedtools intersect   -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/chromatin_states/25_state_12_mark/${roadmap_biospecimen}_25_imputed12marks_mnemonics.bed.gz" -wo | gzip > $output_dir/25_state_$input_file_base_name
bedtools intersect  -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/chromatin_states/15_state_5_mark/${roadmap_biospecimen}_15_coreMarks_mnemonics.bed.gz" -wo | gzip > $output_dir/15_state_$input_file_base_name



bedtools intersect -a $input_file -b "$anno_dir/$roadmap_biospecimen-H3K27ac.narrowPeak.gz" -wo | gzip > $output_dir/H3K27ac_$input_file_base_name
bedtools intersect -a $input_file -b "$anno_dir/$roadmap_biospecimen-H3K27me3.narrowPeak.gz" -wo | gzip > $output_dir/H3K27me3_$input_file_base_name

bedtools intersect -a $input_file -b "$anno_dir/$roadmap_biospecimen-H3K36me3.narrowPeak.gz" -wo | gzip > $output_dir/H3K36me3_$input_file_base_name
bedtools intersect -a $input_file -b "$anno_dir/$roadmap_biospecimen-H3K4me1.narrowPeak.gz" -wo | gzip > $output_dir/H3K4me1_$input_file_base_name
bedtools intersect -a $input_file -b "$anno_dir/$roadmap_biospecimen-H3K4me3.narrowPeak.gz" -wo | gzip > $output_dir/H3K4me3_$input_file_base_name
bedtools intersect -a $input_file -b "$anno_dir/$roadmap_biospecimen-H3K9ac.narrowPeak.gz" -wo | gzip > $output_dir/H3K9ac_$input_file_base_name
bedtools intersect -a $input_file -b "$anno_dir/$roadmap_biospecimen-H3K9me3.narrowPeak.gz" -wo | gzip > $output_dir/H3K9me3_$input_file_base_name