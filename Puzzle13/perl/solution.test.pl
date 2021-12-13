#!/usr/bin/perl

use strict; 
use warnings;
use 5.32.0; 
use Test::More;

require_ok('./solution.pl');

my $input = <<INSTRUCTIONS;
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
INSTRUCTIONS

is_deeply(parse_input($input), {'dot_matrix' => [
[6,10], [0,14], [9,10], [0,3],   [10,4], [4,11], [6,0],
[6,12], [4,1],  [0,13], [10,12], [3,4],  [3,0],  [8,4],
[1,10], [2,14], [8,10], [9,0] ], 'folding_instructions' => [
	{'fold_direction' => 'y', 'fold_position' => 7},
	{'fold_direction' => 'x', 'fold_position' => 5}  ] 
});

is_deeply(fold_paper({'dot_matrix' => [
[6,10], [0,14], [9,10], [0,3],   [10,4], [4,11], [6,0],
[6,12], [4,1],  [0,13], [10,12], [3,4],  [3,0],  [8,4],
[1,10], [2,14], [8,10], [9,0] ], 'folding_instructions' => [
	{'fold_direction' => 'y', 'fold_position' => 7},
	{'fold_direction' => 'x', 'fold_position' => 5}  ] 
}), {'dot_matrix' => [ sort { $a->[0] <=> $b->[0] ? $a->[0] <=> $b->[0]: $a->[1] <=> $b->[1] } (
[6,4 ], [0,0],  [9, 4], [0,3],   [10,4], [4,3], [6,0],
[6,2 ], [4,1],  [0, 1], [10,2], [3,4],  [3,0],  [8,4],
[1,4], [2,0], [9,0]) ], 'folding_instructions' => [
	{'fold_direction' => 'x', 'fold_position' => 5}  ] 
});

is(to_diagram(@{complete_instructions(parse_input($input))->{'dot_matrix'}}), <<IMAGE
#####
#...#
#...#
#...#
#####
IMAGE
);




done_testing;