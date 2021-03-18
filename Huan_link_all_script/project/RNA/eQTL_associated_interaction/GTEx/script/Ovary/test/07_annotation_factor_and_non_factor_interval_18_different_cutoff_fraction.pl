#interval_18 时，对../output/Whole_Blood/Cis_eQTL/hotspot_cis_eQTL/interval_18/whole_blood_segment_hotspot_cutoff_${cutoff}.bed.gz用annotation_bedtools_intersect_interval18.sh进行annotation,得$output_dir/$factor_$input_file_base_name
#extend 100bp
#!/usr/bin/perl
use warnings;
use strict; 
use utf8;
use File::Basename;
use List::Util qw/max min/;
use Env qw(PATH);
use Parallel::ForkManager;

# my @intervals = (18,15,12,9,8,7,6);
my @cutoffs = ();
for (my $i=0.05;$i<0.96;$i=$i+0.05){ #对文件进行处理，把所有未定义的空格等都替换成NONE
    push @cutoffs,$i;
    # print "$i\n";
}
push @cutoffs,0.01;
push @cutoffs,0.99;
my @groups = ("hotspot","non_hotspot");
my @types = ("factor","non_factor");
my @fractions = (0.05,0.1,0.2);
my $pm = Parallel::ForkManager->new(10); ## 设置最大的线程数目
foreach my $type(@types){
    foreach my $group(@groups){
        foreach my $cutoff(@cutoffs){          
            my $pid = $pm->start and next; #开始多线程
            my $input_file = "../output/Whole_Blood/Cis_eQTL/${group}_cis_eQTL/interval_18/whole_blood_segment_${group}_cutoff_${cutoff}.bed.gz";
            # my $output_file = "../../../output/ALL_${QTL}/cis_trans/interval_15/${group}/interval_${interval}_cutoff_7.3_${type}_${QTL}_segment_${group}.bed.gz";
            my $input_file_base_name = basename($input_file);
            # my $dir = dirname($script);
            # print "$input_file_base_name\n";
            foreach my $fraction(@fractions){
                my $output_dir = "../output/Whole_Blood/Cis_eQTL/annotation/interval_18/ALL/${type}/${group}/${cutoff}/${fraction}"; 
                # mkdir $PMID;
                # #------------
                if(-e $output_dir){
                    print "${output_dir}\texist\n";
                }
                else{
                    system "mkdir -p $output_dir";
                }
                #------------
                $ENV{'input_file'}  = $input_file; #设置环境变量
                $ENV{'input_file_base_name'} = $input_file_base_name ;
                $ENV{'output_dir'} = $output_dir ;
                $ENV{'fraction'} = $fraction ;
                my $command = "bash annotation_${type}_bedtools_intersect_interval18_fraction.sh";
                # print "$command\n";
                system $command;
                print "$type\t$group\t$cutoff\t$fraction\n";   
            }
            $pm->finish;  #多线程结束
        }
    } 
}

