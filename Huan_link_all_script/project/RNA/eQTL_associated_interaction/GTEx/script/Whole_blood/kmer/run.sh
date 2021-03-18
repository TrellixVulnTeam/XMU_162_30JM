perl 01_filter_segment_6.pl
bedtools getfasta -fi ~/ref_data/gencode/GRCh37.primary_assembly.genome.fa -bed "/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/Whole_Blood_segment_hotspot_cutoff_0.176_chr1.bed.gz" -fo "/share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/kmer/chr1/Whole_Blood_segment_hotspot_cutoff_0.176_chr1.fa"
cd  /share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/kmer/chr1/

source activate /home/huanhuan/miniconda3
seekr_norm_vectors Whole_Blood_segment_hotspot_cutoff_0.176_chr1.fa
seekr_kmer_counts Whole_Blood_segment_hotspot_cutoff_0.176_chr1.fa -o 6mers.csv -mv mean.npy -sv std.npy

seekr_pearson 6mers.csv 6mers.csv -o example_vs_self.csv
seekr_graph example_vs_self.csv 0.13 -g example_vs_self.gml -c communities.csv
conda deactivate

cd /home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/script/Whole_blood/kmer/

perl 02_annotation_hotspot_interval_18_different_cutoff.pl #interval_18 时，"../../../output/${tissue}/Cis_eQTL/${group}_cis_eQTL/interval_18/whole_blood_segment_${group}_cutoff_${cutoff}.bed.gz"用annotation_bedtools_intersect_interval18.sh进行annotation,得$output_dir/$factor_$input_file_base_name
perl 03_transform_kmer_result.pl 

Rscript 04_veen.R

"/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/script/Whole_blood/random_permutation/38_transform_36.pl"

#--------all
bedtools getfasta -fi ~/ref_data/gencode/GRCh37.primary_assembly.genome.fa -bed "/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/Whole_Blood_segment_hotspot_cutoff_0.176.bed.gz" -fo "/share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/kmer/Whole_Blood_segment_hotspot_cutoff_0.176.fa"
cd  /share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/kmer/ALL
seekr_norm_vectors Whole_Blood_segment_hotspot_cutoff_0.176.fa
seekr_kmer_counts Whole_Blood_segment_hotspot_cutoff_0.176.fa -o 6mers.csv -mv mean.npy -sv std.npy
seekr_pearson 6mers.csv 6mers.csv -o example_vs_self.csv

seekr_graph example_vs_self.csv 0.13 -g example_vs_self.gml -c communities.csv
conda deactivate
rm "/share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/kmer/ALL/example_vs_self.csv"
rm "/share/data0/QTLbase/huan/GTEx/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18_filter/6/kmer/ALL/6mers.csv"
cd /home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/script/Whole_blood/kmer/

perl 03_transform_kmer_result_all.pl

Rscript 04_veen.R

Rscript 05_Pie.R