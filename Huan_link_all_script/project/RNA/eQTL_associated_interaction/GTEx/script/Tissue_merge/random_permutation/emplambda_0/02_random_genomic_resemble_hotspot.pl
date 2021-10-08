#产生10000个与../../../output/${tissue}/Cis_eQTL/${group}_cis_eQTL/interval_18/Tissue_merge_segment_${group}_cutoff_${cutoff}.bed.gz相同的resemble hotspot,"$output_dir/${i}_resemble_${input_file_base_name}"
#!/usr/bin/perl
use warnings;
use strict; 
use utf8;
use File::Basename;
use List::Util qw/max min/;
use Env qw(PATH);
use Parallel::ForkManager;

my $cutoff = 0.176;
my $group = "hotspot";
my $tissue = "Tissue_merge";

my $input_file = "../../../../output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz"; #hotspot
my $input_file_base_name = basename($input_file);
# $input_file_base_name =~ s/Tissue_merge/Tissue_merge/g;
my $cutoff2 = "0";
my $output_dir=  "/share/data0/QTLbase/huan/GTEx/Tissue_merge/Cis_eQTL/interval_18_random/original_random/emp${cutoff}/${cutoff2}";

if(-e $output_dir){
    print "${output_dir}\texist\n";
}
else{
    system "mkdir -p $output_dir";
}

# my $cutoff2 = "0_0.176";
my $anno_dir = "../../../../output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/sampling";
my $whole_genome = "/home/huanhuan/ref_data/UCSC/hg19.chrom1_22_sizes_sorted.txt";

my $basic_simulate = "Tissue_merge_segment_hotspot_cutoff_0.bed.gz";

my $command10 = "bedtools complement -i $anno_dir/$basic_simulate -g $whole_genome | sort -k1,1 -k2,2n |  gzip > $anno_dir/complement_$basic_simulate"; #emp 0 的互补 
system $command10;

my $command11 = "zless $anno_dir/complement_$basic_simulate > $anno_dir/complement_final_0.bed ";

my $command12 = "zless  /home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz >> $anno_dir/complement_final_0.bed"; #Hotspot 进行了extend，所以exclude不仅仅是emp 0 的互补，还有extend的部分 既最终用不在hotspot中的emp0为背景

system $command11;
system $command12;
system "less $anno_dir/complement_final.bed |sort -k1,1 -k2,2n |gzip >$anno_dir/complement_final_0_sorted.bed.gz ";
system "bedtools merge -i $anno_dir/complement_final_0_sorted.bed.gz |gzip >$anno_dir/complement_final_0_sorted_merge.bed.gz"; # exclude  

my $genome="/home/huanhuan/ref_data/UCSC/hg19.chrom1_22.sizes";


for (my $i=1;$i<10001;$i++){
    # my $i=1;
    my $out_file = "$output_dir/${i}_resemble_${input_file_base_name}";
    #generate random file 
    my $command1 = "bedtools shuffle -i $input_file -g $genome -excl $anno_dir/complement_final_sorted_merge.bed.gz -chrom | gzip >$out_file"; #即用$basic_simulate 除去hotspot extend 的部分 进行随机抽样
    # print "$command\n";
    system $command1;
    print "$i\n";
}



