perl 01_Completion_snp_for_cis_trans_eQTL_by_1kg.pl # # 用../../../output/all_1kg_phase3_v5_hg19_snp.txt.gz 补全../../../output/merge_QTL_all_QTLtype_pop_cistrans.txt.gz 得/home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/output/ALL_eQTL/cis_trans/cis_1MB_eQTL_pop_1kg_Completion.txt.gz
#trans_1MB_eQTL_pop_1kg_Completion.txt.gz, trans_1MB_eQTL_pop_1kg_Completion.txt.gz, cis_10MB_eQTL_pop_1kg_Completion.txt.gz,
Rscript 02_huan_NHPoisson.R
perl 03_filter_emplambda_in_eQTL.pl #将../../../output/ALL_eQTL/cis_trans/NHPoisson_emplambda_interval_1000_cutoff_7.3_${name}_eQTL.txt.gz 中的QTLbase中../../../output/merge_QTL_all_QTLtype_pop_cistrans.txt.gz的eQTL数据过滤出来，
#得../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_${name}_eQTL.txt.gz
#并得汇总文件"../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_all_cis_trans_eQTL.txt.gz"
perl 04_normalize.pl #将"../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_all_cis_trans_eQTL.txt.gz" 处理成$cis_or_trans:$emplambda的格式，并将位置处理为bed
#得../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_all_cis_trans_eQTL_normalized.bed.gz
zless ../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_all_cis_trans_eQTL_normalized.bed.gz |awk 'NR>1'|sort -k1,1 -k2,2n > ../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_all_cis_trans_eQTL_normalized_sorted.bed
gzip ../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_all_cis_trans_eQTL_normalized_sorted.bed 



# perl 04_merge_all_cis_trans.pl #将 ../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_${name}_eQTL.txt.gz "cis_1MB","trans_1MB","cis_10MB","trans_10MB" merge到一起得
# #../../../output/ALL_eQTL/cis_trans/QTLbase_NHPoisson_emplambda_interval_1000_cutoff_7.3_cis_trans.txt.gz