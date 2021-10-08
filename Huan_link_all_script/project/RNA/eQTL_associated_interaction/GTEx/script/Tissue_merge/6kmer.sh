bedtools getfasta -fi ~/ref_data/gencode/GRCh37.primary_assembly.genome.fa -bed  "/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz" -fo "/share/data0/QTLbase/huan/GTEx/Tissue_merge/Cis_eQTL/hotspot/interval_18/kmer/6/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.fa"

cd /share/data0/QTLbase/huan/GTEx/Tissue_merge/Cis_eQTL/hotspot/interval_18/kmer/6

source activate /home/huanhuan/miniconda3
seekr_norm_vectors Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.fa
seekr_kmer_counts Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.fa -o 6mers.csv -mv mean.npy -sv std.npy

seekr_pearson 6mers.csv 6mers.csv -o example_vs_self.csv
seekr_graph example_vs_self.csv 0.13 -g example_vs_self.gml -c communities.csv
conda deactivate


cd /home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/script/Tissue_merge/