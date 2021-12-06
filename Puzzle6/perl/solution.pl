#!/usr/bin/perl

use strict; 
use warnings; 
use 5.32.0;

sub decrease {
	my ($fish) = @_;
	
	if ($fish > 0) {
		return $fish -1 ;
	}
	return "6,8";
}

sub nextGeneration {
	my ($generation) = @_;
	
	return join ',', map {decrease($_)} split ',', $generation;
	
}

sub generations {
	my ($fishes, $gencount) = @_;
	
	foreach my $counter ( 1..$gencount) {
		$fishes = nextGeneration($fishes);
	}
	
	return $fishes;
}


sub fishCount {
	my ($fishes) = @_;
	
	return scalar split ',', $fishes; 
}
sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}


if (!caller(0)) {
	my $finalFishCount = fishCount(generations(getInput(), 80));
	
	say "After 80 generations, there will be $finalFishCount fishes";
	
}
1;