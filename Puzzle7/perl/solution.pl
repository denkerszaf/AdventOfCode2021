#!/usr/bin/perl

use strict;
use warnings; 
use 5.32.0;
use List::Util qw(min max);

sub distance {
	my($crabs, $position)  = @_;
	
	my $distance = 0;
	foreach my $crab (@$crabs) {
		$distance += fuel_burn(abs($position - $crab));
	}
	
	return $distance;
}

sub fuel_burn {
	my ($distance) = @_;
	
	return ($distance * ($distance + 1))/2;
}


sub optimalPosition {
	my ($input) = @_;
	
	my @crabs = split ',' , $input;
	
	
	my $minimalPosition = min(@crabs); 
	my $minimalDistance = distance(\@crabs, $minimalPosition); 
	for my $candidate (min(@crabs)..max(@crabs)) {
		my $candidateDistance = distance(\@crabs, $candidate);
		if ($candidateDistance < $minimalDistance) {
			$minimalDistance = $candidateDistance;
			$minimalPosition = $candidate;
		} 
	}
	return ($minimalPosition, $minimalDistance);
}

sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}


if (!caller(0)) {	
	
	my $input = getInput();
	my ($position, $distance) = optimalPosition($input);
	say "optimal distance is $distance"; 
	
}

1;