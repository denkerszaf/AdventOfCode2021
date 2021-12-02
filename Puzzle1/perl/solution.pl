#!/usr/bin/perl 

use 5.32.0;
use warnings; 
use strict;

open (my $fh, '<', '../input') or die 'could not read input';

my $previous = undef;
my $result = 0; 
while (my $line = <$fh>) {
	if (defined $previous) {
		if ($line > $previous) {
			$result++;
		}
	}
	$previous = $line; 
}
close($fh);

say $result;