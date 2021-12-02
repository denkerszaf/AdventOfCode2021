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

sub getIncreasedWindows(@) {
	my @readings = @_;
	my @windows = ();
	for (my $i = 2; $i < scalar(@readings); $i++) {
		push @windows, $readings[$i] +$readings[$i-1] + $readings[$i-2]; 
	}
	return getIncreasedDepths(@windows);
}

if (!caller(0)) {
	my @readings = getReadings();
	my $depths = getIncreasedDepths(@readings);
	my $windows = getIncreasedWindows(@readings);
	say "$depths increased depths, $windows increased windows";
}
1;