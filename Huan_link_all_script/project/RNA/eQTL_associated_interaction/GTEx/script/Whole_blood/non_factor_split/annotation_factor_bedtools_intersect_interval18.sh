bedtools intersect   -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/ROADMAP/E062/enhancer/01_normal_E062-H3K4me1_H3K27ac.narrowPeaksorted_overlap.gz" -wa -wb | gzip > $output_dir/enhancer_$input_file_base_name
bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/ROADMAP/E062/promoter/01_normal_E062-H3K4me3.narrowPeaksorted.gz" -wa -wb | gzip > $output_dir/promoter_$input_file_base_name
bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/Whole_Blood/TFBS_union.bed.gz" -wa -wb | gzip > $output_dir/TFBS_$input_file_base_name

bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/Whole_Blood/CHROMATIN_Accessibility_union.bed.gz" -wa -wb | gzip > $output_dir/CHROMATIN_Accessibility_$input_file_base_name

bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/Whole_Blood/HISTONE_modification_union.bed.gz" -wa -wb | gzip > $output_dir/HISTONE_modification_$input_file_base_name

bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/used_refer/Whole_Blood/CTCF_union.bed.gz" -wa -wb | gzip > $output_dir/CTCF_$input_file_base_name