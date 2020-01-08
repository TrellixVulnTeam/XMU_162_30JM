#将../raw_data/cis_eQTLs_all_re.gz 和../raw_data/trans_eQTLs_all_re.gz normalized 成../normalized/01_normalized.txt.gz
#!/usr/bin/perl
use warnings;
use strict; 
use utf8;




my $fo1 = "../normalized/01_normalized.txt.gz";
open my $O1, "| gzip >$fo1" or die $!;
my $header = "Variant_id\tRs_id\tVariant_Chr\tVariant_Pos\tVariant_Ref\tVariant_Alt\tEffect_allele\tOther_allele\tMaf\tGene_Version\tGene_id\tGene_name\tEntrezGeneID\tGene_Chr\tGene_Start\tGene_End\tSlope\tSlope_se\tZscore\tEffect_size\tP_value\tQ_value\tBeta\tCis_or_Trans\tTissue\tSource";
print $O1 "$header\n";


my @file_types = ("cis","trans");
foreach my $file_type(@file_types){
    my $f1 = "../raw_data/${file_type}_eQTLs_all_re.gz";
    open( my $I1 ,"gzip -dc $f1|") or die ("can not open input file '$f1' \n"); #读压缩文件

    my(%hash1,%hash2,%hash3,%hash4);
    while(<$I1>){
        chomp;
        unless(/^cancer_type/){
            my @f =split/\t/;
            my $Variant_id=$f[1];
            my $Rs_id=$f[1];
            my $Variant_Chr=$f[2];
            my $bp_SNP =$f[3];
            my $Variant_Pos=$bp_SNP;
            my $alleles = $f[4];
            my @t =split/\//,$alleles;
            my $Variant_Ref=$t[0];
            my $Variant_Alt=$t[1];
            my $Effect_allele="NA";
            my $Other_allele="NA";
            my $Maf="NA";
            my $Gene_Version="Hg19";
            my $Gene_id="NA";
            my $Gene_name=$f[5];
            my $EntrezGeneID="NA";
            my $gene_position =$f[6];
            my @c = split/\:/,$gene_position;
            my $Gene_Chr=$c[0];
            my $pos = $c[1];
            my @p = split/\-/,$pos;
            my $Gene_Start=$p[0];
                        # print "$Gene_Start\n";
            my $Gene_End=$p[1];
            my $Slope="NA";
            my $Slope_se="NA";
            my $P_value= $f[-1];
            my $Q_value ="NA"; 
            my $Beta=$f[-3];
            my $Cis_or_Trans=$file_type;
            my $Tissue=$f[0];
            my $Source="PancanQTL";
            my $Effct_sise ="NA";
            my $Zscore ="NA";
            my $output = "$Variant_id\t$Rs_id\t$Variant_Chr\t$Variant_Pos\t$Variant_Ref\t$Variant_Alt\t$Effect_allele\t$Other_allele\t$Maf\t$Gene_Version\t$Gene_id\t$Gene_name\t$EntrezGeneID\t$Gene_Chr\t$Gene_Start\t$Gene_End\t$Slope\t$Slope_se\t$Zscore\t$Effct_sise\t$P_value\t$Q_value\t$Beta\t$Cis_or_Trans\t$Tissue\t$Source";
            print $O1 "$output\n";
        }
    }
}
