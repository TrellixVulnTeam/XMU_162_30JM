wget -c http://hgdownload.soe.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeUwTfbs/files.txt
perl 01_filter_the_need_file_and_create_link.pl #将files.txt中ctcf对于的narrow peak选出来，对于同一样本有重复的，筛选出文件大的哪个，对于并生成download link,得download.sh,和need_file.txt
mkdir data
mv download.sh ./data
cd data
bash data/download.sh
cd ..
perl 02_merge.pl #将data/下面的.gz文件合在一起，并去重得02_all_unique_merge_ctcf_binding_site_narrow_peak.bed.gz
zless 02_all_unique_merge_ctcf_binding_site_narrow_peak.bed.gz | awk 'NR>1'| sort -k1,1 -k2,2n | gzip > 02_all_unique_merge_ctcf_binding_site_narrow_peak_sorted.bed.gz