#!/usr/bin/perl

use strict; 
use warnings; 
use 5.32.0;

sub histogram {
	my ($input) = @_;
	
	my %result = ();
	
	foreach my $value (split ',', $input) {
		$result{$value} =  1 + ($result{$value} // 0); 
	}
	
	return \%result;
	
}

sub unhistogram {
	my ($histogram) = @_;
	
	my @fishtypes = keys %$histogram;
	
	my @fishlist = map { ($_ ) x $$histogram{$_} } @fishtypes;
	
	return join ',', @fishlist;
	
}


sub decrease {
	my ($type, $count) = @_;
	
	my %result; 
	
	if ($type > 0) {
		return ( [$type -1, $count]) ;
	}
	return ([6, $count],[8, $count]);
}

sub nextGeneration {
	my ($generation) = @_;
	
	my %nextgeneration; 
	
	while (my ($type, $count) = each %$generation) {
		my @newmembers = decrease($type, $count);
		foreach my $membertype (@newmembers) {
			$nextgeneration{$membertype->[0]} = ($nextgeneration{$membertype->[0]} // 0) + $membertype->[1] 
		} 
	}
	
	return \%nextgeneration;
	
}

sub generations {
	my ($fishes, $gencount) = @_;
	
	my $fish_histogram = histogram($fishes);
	
	foreach my $counter ( 1..$gencount) {
			$fish_histogram = nextGeneration($fish_histogram);
	}
	
	return $fish_histogram;
}


sub fishCount {
	my ($fish_histogram) = @_;
	
	my $sum = 0;
	foreach my $count (values %$fish_histogram) {
		$sum += $count;
	} 
	
	return $sum;
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
	my %input = histogram($input);
	my $gen80 = fishCount(generations($input, 80));
	say "After 80 generations, there will be $gen80 fishes";
	
	my $gen256 = fishCount(generations($input, 256));
	say "After 256 generations, there will be $gen256 fishes";
	
}
1;