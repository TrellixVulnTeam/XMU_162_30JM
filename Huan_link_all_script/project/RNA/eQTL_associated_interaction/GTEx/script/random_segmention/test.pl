#!/usr/bin/perl
use warnings;
use strict; 
use utf8;



my @files=(1,2,3,8,5,6,7,4);
my @sorted_files = sort {$a <=> $b} @files;
print "@sorted_files\n";