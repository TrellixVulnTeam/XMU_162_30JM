wget -c ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_28/gencode.v28.annotation.gff3.gz
#hg38, gff
wget -c https://fantom.gsc.riken.jp/5/datafiles/latest/extra/CAGE_peaks/hg19.cage_peak_phase1and2combined_coord.bed.gz
perl 01_normalized.pl ##将hg19.cage_peak_phase1and2combined_coord.bed.gz 提出需要的列，并加header,得fantom5_promoter_phase1_phase2.bed.gz
zless fantom5_promoter_phase1_phase2.bed.gz |sort -k1,1 -k2,2n |gzip >fantom5_promoter_phase1_phase2_sorted.bed.gz