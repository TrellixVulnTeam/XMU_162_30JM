#!/usr/bin/env perl
use warnings;


# Copyright 2009 - 2017 Christopher Benner <cbenner@ucsd.edu>
#
# This file is part of HOMER
#
# HOMER is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# HOMER is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.


my $covThresh = 0.15;


sub printCMD {
	print STDERR "\n\tusage: subtractBedGraphs.pl <bedgraph 1> <bedgraph 2> [options]\n";
	print STDERR "\n\tOptions:\n";
	print STDERR "\t\t-cov <coverage bedGraph> (to remove regions with low coverage)\n";
	print STDERR "\t\t\t-covThresh <#> (fraction of average coverage below which to skip region, default: $covThresh)\n";
	print STDERR "\t\t-name <bedgraph track name> (name for track, default: autogenerated)\n";
	print STDERR "\t\t-center (Center output on the mean of the bedGraph - remove global drift)\n";
	print STDERR "\n";
	exit;
}




my $file1 = '';
my $file2 = '';
my $file3 = '';
my $name = '';
my $centerFlag = 0;

if (@ARGV < 3) {
	printCMD();
}
for (my $i=0;$i<@ARGV;$i++) {
	if ($ARGV[$i] eq '-cov') {
		$file3 = $ARGV[++$i];
	} elsif ($ARGV[$i] eq '-name') {
		$name = $ARGV[++$i];
	} elsif ($ARGV[$i] eq '-center') {
		$centerFlag = 1;
	} elsif ($ARGV[$i] eq '-covThresh') {
		$covThresh = $ARGV[++$i];
	} else {
		if ($ARGV[$i] =~ /^\-/) {
			printCMD();
		}
		if ($file1 eq '') {
			$file1 = $ARGV[$i];
		} elsif ($file2 eq '') {
			$file2 = $ARGV[$i];
		} else {
			print STDERR "!!! Warning - bedGraph files ($file1, $file2) already specified\n";
			exit;
		}
	}
}

my $rand = rand();
my $tmpfile = $rand . ".tmp";
my $tmpfile2 = $rand . ".2.tmp";

`bed2pos.pl $file1 > $tmpfile`;
`renamePeaks.pl $tmpfile > $tmpfile2`;
`annotatePeaks.pl $tmpfile2 none -bedGraph $file1 $file2 $file3 -noblanks > $tmpfile`;

my @peaks = ();
my $sumCoverage = 0;
my $N = 0;
open IN, $tmpfile;
my $c = 0;
while (<IN>) {
	$c++;
	chomp;
	s/\r//g;
	my @line = split /\t/;
	if ($c==1) {
		if ($name eq '') {
			$line[20] =~ s/^.*\///;
			$line[19] =~ s/^.*\///;
			$line[20] =~ s/\.bedGraph.*$//;
			$line[19] =~ s/\.bedGraph.*$//;
			$name = "$line[20] vs. $line[19]";
		}
		next;
	}
	next if (@line < 21);
	my $cov= 0;
	if (@line > 21 && $line[21] ne 'nan') {
		$cov = $line[21];
		$sumCoverage += $line[21];
		$N++;
	}
	my $v = $line[20]-$line[19];
	my $p = {c=>$line[1],s=>$line[2],e=>$line[3],v=>$v,o=>$cov};
	push(@peaks, $p);
}
close IN;

my $good = 0;
my $total = 0;
my $sigAvg = 0;
if ($N > 0) {
	my $avg = $sumCoverage/$N;
	my @newpeaks = ();
	foreach(@peaks) {
		$total++;
		#print STDERR "$_->{'o'}\t$avg\n";
		if ($_->{'o'} > $avg*$covThresh) {
			push(@newpeaks, $_);
			$sigAvg += $_->{'v'};
			$good++;
		}
	}
	@peaks = @newpeaks;
} else {
	foreach(@peaks) {
		push(@newpeaks, $_);
		$total++;
		$good++;
		$sigAvg += $_->{'v'};
	}
}
my $den = $good;
$den = 1 if ($good < 1);
$sigAvg /= $den;
print STDERR "Good/Total = $good/$total (avg signal = $sigAvg)\n";

@newpeaks = sort {$a->{'c'} cmp $b->{'c'} || $a->{'s'} <=> $b->{'s'}} @peaks;

print "track name=\"$name\" type=bedGraph autoScale=On visibility=2 alwaysZero=on viewLimits=\"-3:3\"\n";
foreach(@newpeaks) {
	my $v = $_->{'v'};
	if ($centerFlag) {
		$v -= $sigAvg;
	}
	print "$_->{'c'}\t$_->{'s'}\t$_->{'e'}\t$v\n";
}
`rm $tmpfile $tmpfile2`;
