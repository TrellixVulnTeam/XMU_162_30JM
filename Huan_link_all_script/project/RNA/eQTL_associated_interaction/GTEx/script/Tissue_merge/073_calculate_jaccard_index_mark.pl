#对 $input_dir/${mark}_Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz 计算 jaccard index得$out_dir/${group}_cutoff_${cutoff}_marker_jaccard_index.txt.gz
#!/usr/bin/perl
use warnings;
use strict; 
use utf8;
use File::Basename;
use List::Util qw/max min/;
use List::Util qw/sum/;
use Env qw(PATH);
use Parallel::ForkManager;

my $cutoff = 0.176;
my $group = "hotspot";
my $tissue = "Tissue_merge";


my $input_dir = "/share/data0/QTLbase/huan/GTEx/Tissue_merge/Cis_eQTL/annotation/";

# my @markers = ("H3K27ac","H3K27me3","H3K36me3","H3K4me1","H3K4me3","H3K9ac","H3K9me3");
my @markers = ("H3K27ac","H3K27me3","H3K36me3","H3K4me1","H3K4me3","H3K9ac","H3K9me3","CHROMATIN_Accessibility","TFBS","CTCF");
my $out_dir=  "../../output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/enrichment/";



my $fo1 = "$out_dir/${group}_cutoff_${cutoff}_marker_jaccard_index.txt.gz";
# open my $O1, '>', $fo1 or die "$0 : failed to open output file '$fo1' : $!\n";
open my $O1, "| gzip >$fo1" or die $!;

print $O1 "Marker\tjaacard_index\n";

foreach my $mark (@markers){
    my %hash1;
    my $input_file_base_name = "${mark}_Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz";
    my $input_file = "$input_dir/$input_file_base_name";
    my $f2 = $input_file;
    open( my $I2 ,"gzip -dc $f2|") or die ("can not open input file '$f2' \n"); #读压缩文件

    while(<$I2>)
    {
        chomp;
        my @f = split/\t/;
        my $hotspot_chr = $f[0];
        my $hotspot_start = $f[1];
        my $hotspot_end = $f[2];
        my $factor_chr = $f[3];
        my $factor_start = $f[4];
        my $factor_end = $f[5];
        my $overlap_bp = $f[-1];
        my $factor_length = $factor_end - $factor_start;
        my $k = "$hotspot_chr\t$hotspot_start\t$hotspot_end";
        my $v = "$factor_chr\t$factor_start\t$factor_end\t$overlap_bp";
        push @{$hash1{$k}},$v;
    }

    foreach my $k(sort keys %hash1){
        my @vs = @{$hash1{$k}};
        my %hash;
        @vs = grep { ++$hash{$_} < 2 } @vs;
        my @overlaps =();
        my @factor_lengths =();
        my @ss = split/\t/,$k;
        my $hotspot_chr = $ss[0];
        my $hotspot_start = $ss[1];
        my $hotspot_end = $ss[2];
        my $hotspot_length = $hotspot_end - $hotspot_start;
        foreach my $v(@vs){
            my @t=split/\t/,$v;
            my $factor_chr = $t[0];
            my $factor_start = $t[1];
            my $factor_end =$t[2];
            my $overlap_bp =$t[3];
            my $factor_length = $factor_end - $factor_start;
            push @overlaps, $overlap_bp;
            push @factor_lengths, $factor_length;
        }
        my $all_overlap = sum @overlaps;
        my $all_factor_length =sum @factor_lengths;
        my $denominator = $all_factor_length+$hotspot_length-$all_overlap;
        my $jaccard_index = $all_overlap/$denominator;
        print $O1 "$mark\t$jaccard_index\n";
    }
    my $f3 = "/home/huanhuan/project/RNA/eQTL_associated_interaction/GTEx/output/Tissue_merge/Cis_eQTL/hotspot_cis_eQTL/interval_18/Tissue_merge_segment_hotspot_cutoff_0.176_extend_sorted_merge.bed.gz";
    open( my $I3 ,"gzip -dc $f3|") or die ("can not open input file '$f3' \n"); #读压缩文件

    while(<$I3>)
    {
        chomp;
        my @f = split/\t/;
        my $chr = $f[0];
        my $start = $f[1];
        my $end =$f[2];
        my $k = "$chr\t$start\t$end";
        unless (exists $hash1{$k}){
            print $O1 "$mark\t0\n";
        }
    }

}