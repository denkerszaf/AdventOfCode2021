#!/usr/bin/perl 

use strict; 
use warnings;
use List::Util qw(reduce);
use List::MoreUtils qw(uniq);
use 5.32.0;

sub getNeighbors {
	my ( $x, $y , $maxx, $maxy) = @_;
	
	my @result = ();
	push @result, [ $x -1 , $y ] if $x > 0;
	push @result, [ $x, $y -1 ] if $y > 0;
	push @result, [ $x + 1, $y ] if $x < $maxx;
	push @result, [ $x, $y + 1 ] if $y < $maxy;
	
	return @result; 
}

sub transformInput {
	my ($input) = @_;
	chomp $input;
	return [ map { [ split '', $_ ] } split /\n/, $input ];
}

sub lowPoints {
	
	my ($input) = @_;
	my @input = @$input;
	my $maxx = scalar @input -1;
	my $maxy = scalar @{$input[0]} - 1;
	
	my @lowpoints = ();
	for (my $rowindex = 0; $rowindex <= $maxx; $rowindex++) {
		for (my $colindex = 0; $colindex <= $maxy; $colindex++) {
			push @lowpoints, { 'x' => $rowindex, 'y' => $colindex, 'height' => $input[$rowindex][$colindex]} 
				unless scalar grep {$_ <= $input[$rowindex][$colindex]} 
					map { my ($x, $y) = @$_; $input[$x][$y] } 
					getNeighbors($rowindex, $colindex, $maxx, $maxy);
			 
			
		}
	}
	return \@lowpoints;
}

sub same_point {
	my ($a, $b) = @_;
	
	return (($a->[0] == $b->[0]) and ($a->[1] == $b->[1])); 
}

sub uniq_points {
	my (@points) = @_;
	
	my %temp = map { $_->[0] . ',' . $_->[1] => $_ } @points;
	
	return values %temp;

}

sub basins {
	my ($input, $lowpoints)  = @_;
	
	my $maxx = scalar @$input -1;
	my $maxy = scalar @{$input->[0]} - 1;
	
	
	my @basin_sizes = ();
	
	foreach my $point (@$lowpoints) {
		my @basin_points = ( [$point->{'x'}, $point->{'y'} ] );
		my $basin_size = 1;
		do {
			$basin_size = scalar @basin_points;
			my @basin_candidates =  grep { 9 >  $input->[$_->[0]][$_->[1]]  } map { getNeighbors($_->[0], $_->[1] , $maxx, $maxy) } @basin_points;
			@basin_points = uniq_points(@basin_points, @basin_candidates);
		} while ($basin_size < scalar @basin_points); 
		
		push @basin_sizes, scalar @basin_points;
	}
	
	return [ sort { $b > $a} @basin_sizes ];
	
}

sub risk_rating {
	my ($low_points) = @_;
	
	return reduce {$a + $b } map { $_->{'height'} + 1} @$low_points;
	
}

sub size {
	reduce { $a * $b } sort {$b <=> $a } @_[0..2];
}

sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}

if (!caller(0)) {	
	
	my $input = transformInput(getInput());
	my $lowPoints = lowPoints($input);
	my $risk_rating = risk_rating($lowPoints);
	
	my @big_basins = sort {$b <=> $a } @{basins($input, $lowPoints)};
	my ($a, $b, $c) = @big_basins[0..2];
	say "risk rating is $risk_rating";
	say "basin_size is " . $a * $b * $c;

	
}

1;