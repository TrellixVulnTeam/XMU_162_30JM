#因为每个片段会被多个chrom state 注释，根据对hotspot的覆盖比例，选出覆盖比例最高的state, interval_18 时，对"/share/data0/QTLbase/huan/GTEx/${tissue}/Cis_eQTL/interval_18/annotation/ALL/${group}/${cutoff}/background_original_random/$cutoff2/${state}_state_resemble_${i}_resemble_${tissue}_segment_${group}_cutoff_${cutoff}.bed.gz"进行过滤，得$dir/filter_$name
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
my $tissue = "Whole_Blood";
my $state =15;
my $cutoff2 = "0";

my $dir = "/share/data0/QTLbase/huan/GTEx/${tissue}/Cis_eQTL/interval_18/annotation/ALL/${group}/${cutoff}/background_original_random/$cutoff2";
my $pm = Parallel::ForkManager->new(40); ## 设置最大的线程数目
for (my $i=1;$i<10001;$i++){
    my $pid = $pm->start and next; #开始多线程
    my $name = "${state}_state_resemble_${i}_resemble_${tissue}_segment_${group}_cutoff_${cutoff}.bed.gz";
    my $f1 = "$dir/$name";
    # open my $I1, '<', $f1 or die "$0 : failed to open input file '$f1' : $!\n"; 
    open( my $I1 ,"gzip -dc $f1|") or die ("can not open input file '$f1' \n"); #读压缩文件
    my $fo1 = "$dir/filter_$name";
    # open my $O1, '>', $fo1 or die "$0 : failed to open output file '$fo1' : $!\n";
    open my $O1, "| gzip >$fo1" or die $!;
    print $O1 "hotspot_chr\thotspot_start\thotspot_end\tchromatin_chr\tchromatin_start\tchromatin_end\tchromatin_state\toverlap_bp\toverlap_hotspot_ratio\n";
    my (%hash1,%hash2);
    while(<$I1>)
    {
        chomp;
        my @f =split/\t/;
        my $hotspot_chr=$f[0];
        my $hotspot_start = $f[1];
        my $hotspot_end = $f[2];
        my $chromatin_state = join("\t",@f[3..6]);
        my $overlap_bp =$f[-1];
        my $hotspot_length = $hotspot_end-$hotspot_start;
        my $overlap_hotspot_ratio = $overlap_bp/$hotspot_length;
        my $hotspot = join("\t",@f[0..2]);
        push @{$hash1{$hotspot}},$overlap_hotspot_ratio;
        my $k2= "$hotspot\t$overlap_hotspot_ratio";
        push @{$hash2{$k2}},$_;
        
    }

    foreach my $k1 (keys %hash1){
        my @overlap_hotspot_ratios = @{$hash1{$k1}};
        my @sorted_overlap_hotspot_ratios = sort {$b <=> $a} @overlap_hotspot_ratios; #按照数字降序排列
        my $top_ratio = $sorted_overlap_hotspot_ratios[0]; #find top chromatin state overlap_hotspot_ratios
        my $k2 = "$k1\t$top_ratio";
        my @top_lines = @{$hash2{$k2}};
        my $number =@top_lines;
        foreach my $line(@top_lines){ #1,2,3
            print $O1 "$line\t$top_ratio\n";
        }     
    }
    close($I1);
    # my $command = "rm $f1";
    # system $command;
    print "$i\n";
    $pm->finish;  #多线程结束
}




