#!/usr/bin/perl

use strict; 
use warnings;
use 5.32.0; 
use Test::More;

my $input = <<POLY;
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
POLY

require_ok('./solution.pl');

is_deeply(parse_input($input), {'template' => 'NNCB', 'rules' => {
'CH' => 'B',
'HH' => 'N',
'CB' => 'H',
'NH' => 'C',
'HB' => 'C',
'HC' => 'B',
'HN' => 'C',
'NN' => 'C',
'BH' => 'H',
'NC' => 'B',
'NB' => 'B',
'BN' => 'B',
'BB' => 'N',
'BC' => 'B',
'CC' => 'N',
'CN' => 'C'
}});

is(polymerize(parse_input($input))->{'template'}, 'NCNBCHB' );


done_testing;