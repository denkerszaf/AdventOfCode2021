#!/usr/bin/perl 

use 5.32.0;
use warnings; 
use strict;

sub getReadings() {
	open (my $fh, '<', '../input') or die 'could not read input';
	my @readings = <$fh>;
	close($fh);
	return @readings;
}

sub getIncreasedDepths(@){
	my @readings = @_;
	my $previous = undef;
	my $result = 0; 
	
	foreach my $line ( @readings) {
		if (defined $previous) {
			if ($line > $previous) {
				$result++;
			}
		}
		$previous = $line; 
	}
	return $result;
}

if (!caller(0)) {
	my @readings = getReadings();
	my $result = getIncreasedDepths(@readings);
	say $result;
}
1;