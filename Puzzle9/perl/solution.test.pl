#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

my $input = <<HEIGHTMAP;
2199943210
3987894921
9856789892
8767896789
9899965678
HEIGHTMAP

require_ok('./solution.pl');

my $lowpoints =lowPoints(transformInput($input)) ; 

is_deeply($lowpoints, [ { 'x' => 0,'y' => 1, 'height' => 1}, { 'x' => 0,'y' => 9, 'height' => 0}, { 'x' => 2,'y' => 2, 'height' => 5}, { 'x' => 4,'y' => 6, 'height' => 5}]);
is_deeply(basins(transformInput($input), $lowpoints), [14,9,9,3]);
	
is(risk_rating($lowpoints), 15);
done_testing;