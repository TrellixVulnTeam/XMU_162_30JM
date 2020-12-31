wget -c https://storage.googleapis.com/gtex_analysis_v8/single_tissue_qtl_data/GTEx_Analysis_v8_eQTL.tar
tar xvf GTEx_Analysis_v8_eQTL.tar
wget -c https://storage.googleapis.com/gtex_analysis_v8/single_tissue_qtl_data/GTEx_Analysis_v8_sQTL.tar
tar xvf GTEx_Analysis_v8_sQTL.tar
wget -c https://storage.googleapis.com/gtex_analysis_v8/reference/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz

wget -c https://storage.googleapis.com/gtex_analysis_v8/reference/WGS_Feature_overlap_collapsed_VEP_short_4torus.MAF01.txt.gz  #Functional annotation of variants with MAF ≥ 0.01 in the format used by Torus