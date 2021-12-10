#!/usr/bin/perl 

use strict;
use warnings; 
use 5.32.0;
use Test::More; 

require_ok('./solution.pl');
foreach my $corrupted_line (
		'{([(<{}[<>[]}>{[]{[(<()>',
		'>', 
		'[[<[([]))<([[{}[[()]]]',
		'[{[{({}]{}}([{[{{{}}([]',
		'[<(<(<(<{}))><([]([]()',
		'<{([([[(<>()){}]>(<<{{',
	) {
	ok (! scalar legal($corrupted_line), "input $corrupted_line is not legal");
}

foreach my $incomplete ('(((({<>}<{<{<>}{[]{[]{}') {
	ok(legal($incomplete), "input $incomplete is legal");
}

done_testing;