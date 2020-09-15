use warnings;
use strict; 
use utf8;
use List::Util qw/max min/;

my (%hash1,%hash2,%hash3,%hash4);
my @words = qw(foo bar baz foo zorg baz);

my @unique = uniq( @words );
print "@unique"