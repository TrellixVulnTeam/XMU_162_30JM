#------------------------------------------------------------
perl 01_merge_all_kinds_QTL.pl #将../data/中的各种QTL merge到一起，得../output/01_all_kinds_QTL.txt
perl 02_annotate_gene_type.pl #为../output/01_all_kinds_QTL.txt添加genetype 得../output/02_annotate_gene_type.txt.gz
#用"/home/huanhuan/ref_data/Ensembl/output/Hg19_reference_geneome_data_from_ensembl_BioMart_entrez.txt"， "/home/huanhuan/ref_data/RNA_position/data/hg19_v19_miRNA_position.txt"，
#"/home/huanhuan/ref_data/RNA_position/data/hg19_mRNA_position.txt"和"/home/huanhuan/ref_data/RNA_position/data/gencode.v32lift37.long_noncoding_RNAs.gff3.gz"为../output/01_all_kinds_QTL.txt 注释gene type
perl 03_count_snp_QTL_number_in_each_gene_type_and_QTL_type.pl #count ../output/02_annotate_gene_type.txt.gz 各类QTL的数量得文件../output/03_QTL_type_number.txt  在特定QTL种类下的gene type及数量。
#及所有的QTL对应的QTL的数量。
perl count_snp_trait_pos_distance.pl # 计算 ../output/01_all_kinds_QTL.txt中snp 与trait的位置差，得../output/count_snp_trait_pos_distance.txt
Rscript snp_trait_pos_distance_density.R #

#-------------------------------------------------
perl clump_by_sourceid.pl ##分source进行clump,将不同类型QTL按照sourceid分割成"../output/used_to_clump/$used_to_clump"，然后用对应的人种文件/share/data0/1kg_phase3_v5_hg19/${Population}/1kg.phase3.v5.shapeit2.${pop}.hg19.all.SNPs.uniq.posID
#进行clump, 得../output/clump/${used_to_clump}.clump
#--------------------------------------------------------------------------------------------------
perl 01_clump_by_tissue_pop_0.5.pl ##分source进行clump,将不同类型QTL按照tissue 和 population 分割成"../output/tissue_pop_used_to_clump/$used_to_clump"，然后用对应的人种文件/share/data0/1kg_phase3_v5_hg19/${Population}/1kg.phase3.v5.shapeit2.${pop}.hg19.all.SNPs.uniq.posID
#进行clump, 得 ../output/tissue_pop_used_to_clump/$used_to_clump.clump
perl 02_merge_tag_snp_0.5.pl #将../output/tissue_pop_used_to_clump/$used_to_clump 和../output/tissue_pop_used_to_clump/${used_to_clump}.clump merge 起来，并且计算每个LD的长度得../output/clump_region/$used_to_clump
#得总文件../output/all_qtl_clump_locus_r_square0.5.txt.gz
#----------------------------------------------QTL hotspot
#
perl count_qtl_per_source.pl # #统计../output/all_qtl_clump_locus_r_square0.5.txt.gz中pop_tissue_qtl的数目，得../output/number_of_pop_tissue_qtl.txt, 排序得../output/sorted_number_of_pop_tissue_qtl.txt
#得mQTL    Blood   EUR数目最多为470179
cat ../output/number_of_pop_tissue_qtl.txt | sort -k4nr >../output/sorted_number_of_pop_tissue_qtl.txt #
perl count_per_region_QTL_number.pl #统计../output/all_qtl_clump_locus_r_square0.5.txt.gz 中每特定距离中QTL(tag snp的数量)，得../output/count_per_100kb_QTL_number.txt
perl count_per_region_snp_number.pl #统计../output/01_all_kinds_QTL.txt 中每特定距离中snp的数量，得../output/count_per_500bp_snp_number.txt, ../output/count_per_750bp_snp_number.txt, ../output/count_per_1000bp_snp_number.txt
#../output/count_per_500bp_snp_number_region.txt, ../output/count_per_750bp_snp_number_region.txt, ../output/count_per_1000bp_snp_number_region.txt
zless "/home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/data/all.txt.gz" | perl -ane "print $f1"
perl filter_chr22.pl #
perl region_QTL.pl #

Rscript per_region_QTL_number.R #
Rscript QTL_density.R
Rscript NHPoisson.R 
Rscript huan_NHPoisson.R
Rscript Manhattan_plot.R #
Rscript density_NHPoisson.R
perl count_number_in_different_interval.pl 
#-------------------


#-----------------------------------------length of locus distance 
    zless /home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/output/all_qtl_clump_locus.txt.gz |cut -f9,10,11,12,13 | sort -u -r | gzip > ../output/unique_by_qtl_tissue_pop_locus.txt.gz
    zless ../output/unique_by_qtl_tissue_pop_locus.txt.gz | cut -f1 | sort -u | wc -l #2509339 -1 = 2509338
    zless ../output/unique_by_qtl_tissue_pop_locus.txt.gz | cut -f1,2,3,5 | sort -u -r | gzip > ../output/unique_by_qtl_pop_locus.txt.gz

    Rscript locus_distance_density_and_point.R  # 画../output/all_qtl_clump_locus.txt.gz 的distnace 的density plot 和point plot,画point plot失败
    Rscript unique_locus_distance_density_and_point.R  # 画../output/unique_by_qtl_tissue_pop_locus.txt.gz 和 ../output/unique_by_qtl_pop_locus.txt.gz 的distance 的density plot 和point plot, 画point plot失败

    #----------------------------------------

    perl count_of_different_distance_of_region.pl #统计../output/unique_by_qtl_tissue_pop_locus.txt.gz中不同区段长度的数目，得../output/count_of_different_distance_of_region.txt

    Rscript bar_plot_distance_of_region.R 

#--------------------------------------------------------------count p value
Rscript multi_unique_locus_distance_density_and_point.R
#
cat ../output/01_all_kinds_QTL.txt | cut -f7,9|gzip > QTL_specific_Pvalue.txt.gz
Rscript pvalue_density.R


#
perl analysis_json.pl