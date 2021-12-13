#!/usr/bin/perl

use strict; 
use warnings; 
use 5.32.0;
use List::Util qw(reduce);

sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}


if (!caller(0)) {	
}

1; 