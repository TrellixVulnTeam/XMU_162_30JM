wget -c https://fantom.gsc.riken.jp/5/datafiles/latest/extra/Enhancers/human_permissive_enhancers_phase_1_and_2.bed.gz
perl 01_normalized.pl #将human_permissive_enhancers_phase_1_and_2.bed.gz 提出需要的列，并加header,得fantom5_enhancers_phase1_phase2.bed.gz
zless fantom5_enhancers_phase1_phase2.bed.gz | sort -k1,1 -k2,2n |gzip >fantom5_enhancers_phase1_phase2_sorted.bed.gz