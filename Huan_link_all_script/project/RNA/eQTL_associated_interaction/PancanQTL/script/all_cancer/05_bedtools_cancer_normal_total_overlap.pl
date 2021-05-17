# 相同组织，cancer 和 normal -f 1 intersect ，找全部share的hotspot,得my $out1 = "../../output/cancer_total/share/total/${cancer}_contain_${tissue}.bed";my $out2 = "../../output/cancer_total/share/total/${tissue}_contain_${cancer}.bed";
#得汇总文件"../../output/cancer_total/share/total/05_cancer_tissue_intersect_total.bed.gz",
#!/usr/bin/perl
use warnings;
use strict; 
use utf8;
use List::Util qw/max min/;
use Parallel::ForkManager;
my @cutoffs;
my $cutoff =0.176;
# my $tissue = "Lung";
my $j = 18;

my $fo1 = "../../output/cancer_total/share/total/05_cancer_tissue_intersect_total.bed.gz";
open my $O1, "| gzip >$fo1" or die $!;


my $f1 = "../../data/pancanQTL_gtex_eQTL.txt";
open my $I1, '<', $f1 or die "$0 : failed to open input file '$f1' : $!\n"; 
my %hash1;
while(<$I1>)
{
    chomp;
    unless(/^Study/){
       my @f= split/\t/;
       my $cancer=$f[0];
       $cancer =~ s/\s+//g;
       my $GTEx_tissue=$f[-1];
       my @ts=split/;/,$GTEx_tissue;
    #    print "$cancer\n";
       foreach my $t(@ts){
           push @{$hash1{$cancer}},$t;
       }
    }
}    

my @cancers =  ("ACC","BRCA","COAD","ESCA","KICH","KIRC","KIRP","LAML","LIHC","LUAD","LUSC","OV","PAAD","PRAD","SKCM","STAD","TGCT","THCA","UCEC","UCS"); 

foreach my $cancer(@cancers){
    # print "$cancer\n";
    if(exists $hash1{$cancer}){
        # print "$cancer\n";
        my @tissues =@{$hash1{$cancer}};
        foreach my $tissue(@tissues){
            my $file1 = "../../output/${cancer}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${cancer}_segment_hotspot_cutoff_${cutoff}.bed.gz";
            my $tissue11 = $tissue;
            $tissue11 =~ s/Whole_Blood/whole_blood/g;  #Whole_Blood dir name 和 file name不一样，所以引入两个变量
            my $file2 = "../../../GTEx/output/${tissue}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${tissue11}_segment_hotspot_cutoff_${cutoff}.bed.gz";
            my $out1 = "../../output/cancer_total/share/total/${cancer}_contain_${tissue}.bed";
            my $out2 = "../../output/cancer_total/share/total/${tissue}_contain_${cancer}.bed";
            my $command1 = "bedtools intersect -f 1 -a $file1 -b $file2 -wo >$out1";
            my $command2 = "bedtools intersect -f 1 -a $file2 -b $file1 -wo >$out2";
            system $command1;
            system $command2;
            
            #_--------------------
            my $f2 = $out1;
            open my $I2, '<', $f2 or die "$0 : failed to open input file '$f2' : $!\n";  

            while(<$I2>)
            {
                chomp;
                my @f= split/\t/;
                print $O1 "$_\t$cancer\t$tissue\n";
            }   

            print "$cancer\t$tissue\n";

            my $f3 = $out2;
            open my $I3, '<', $f3 or die "$0 : failed to open input file '$f3' : $!\n"; 

            while(<$I3>)
            {
                chomp;
                my @f= split/\t/;
                print $O1 "$_\t$tissue\t$cancer\n";
            }             
            print "$tissue\t$cancer\n";

        }
    }
}









# my @tissues =  ("Adipose_Subcutaneous","Adipose_Visceral_Omentum","Adrenal_Gland","Artery_Aorta","Brain_Anterior_cingulate_cortex_BA24","Brain_Caudate_basal_ganglia","Brain_Cerebellum","Brain_Cortex","Brain_Frontal_Cortex_BA9","Brain_Hippocampus","Brain_Spinal_cord_cervical_c-1","Brain_Substantia_nigra","Cells_EBV-transformed_lymphocytes","Colon_Sigmoid","Colon_Transverse","Esophagus_Gastroesophageal_Junction","Esophagus_Mucosa","Esophagus_Muscularis","Heart_Atrial_Appendage","Heart_Left_Ventricle","Kidney_Cortex","Muscle_Skeletal","Skin_Not_Sun_Exposed_Suprapubic","Skin_Sun_Exposed_Lower_leg","Small_Intestine_Terminal_Ileum","Spleen","Stomach","Uterus","Prostate","Brain_Cerebellar_Hemisphere","Testis","Brain_Nucleus_accumbens_basal_ganglia","Minor_Salivary_Gland","Cells_Cultured_fibroblasts","Pituitary","Vagina","Thyroid","Artery_Tibial","Artery_Coronary","Brain_Hypothalamus","Nerve_Tibial","Brain_Putamen_basal_ganglia","Brain_Amygdala","Breast_Mammary_Tissue","Liver","Lung","Ovary","Pancreas","Whole_Blood");

# my $fo1 = "../../output/Tissue_total/share/total/05_all_tissue_intersect.bed.gz";
# open my $O1, "| gzip >$fo1" or die $!;

# print $O1 "tissue1_chr\ttissue1_start\ttissue1_end\ttissue2_chr\ttissue2_start\ttissue2_end\toverlap_bp\ttissue1\ttissue2\n";

# for my $tissue1(@tissues){
#     my $tissue11 = $tissue1; 
#     $tissue11 =~ s/Whole_Blood/whole_blood/g;  #Whole_Blood dir name 和 file name不一样，所以引入两个变量
#     my $file1 = "../../output/${tissue1}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${tissue11}_segment_hotspot_cutoff_${cutoff}.bed.gz";
#     for my $tissue2(@tissues){
#         my $tissue22 = $tissue2;
#         $tissue22 =~ s/Whole_Blood/whole_blood/g;
#         unless ($tissue1 eq $tissue2){
#             my $file2 = "../../output/${tissue2}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${tissue22}_segment_hotspot_cutoff_${cutoff}.bed.gz";
#             my $command = "bedtools intersect -f 1 -a $file1 -b $file2 -wo >tmp.bed";
#             # print "$command\n";
#             system $command;
#             my $f1 = "tmp.bed";
#             open my $I1, '<', $f1 or die "$0 : failed to open input file '$f1' : $!\n"; 

#             while(<$I1>)
#             {
#                 chomp;
#                 my @f= split/\t/;
#                 print $O1 "$_\t$tissue1\t$tissue2\n";
#             }           
#             print "$tissue1\t$tissue2\n";

#         }
#     }
# }
