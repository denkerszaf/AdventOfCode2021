#!/usr/bin/perl 

use strict;
use warnings; 
use 5.32.0;
use Test::More; 

require_ok('./solution.pl');

my @test_input = (
"[({(<(())[]>[[{[]{<()<>>",
"[(()[<>])]({[<{<<[]>>(",
"{([(<{}[<>[]}>{[]{[(<()>",
"(((({<>}<{<{<>}{[]{[]{}",
"[[<[([]))<([[{}[[()]]]",
"[{[{({}]{}}([{[{{{}}([]",
"{<[[]]>}<{[{[{[]{()[[[]",
"[<(<(<(<{}))><([]([]()",
"<{([([[(<>()){}]>(<<{{",
"<{([{{}}[<[[[<>{}]]]>[]]");

foreach my $corrupted_line (
		'{([(<{}[<>[]}>{[]{[(<()>',
		'>', 
		'[[<[([]))<([[{}[[()]]]',
		'[{[{({}]{}}([{[{{{}}([]',
		'[<(<(<(<{}))><([]([]()',
		'<{([([[(<>()){}]>(<<{{',
	) {
	my $ret = scalar legal($corrupted_line);
	ok (! $ret, "input $corrupted_line is not legal");
}
my @result = legal('{([(<{}[<>[]}>{[]{[(<()>');
is_deeply($result[0],{'expected' => ']', 'found' => '}'});

foreach my $incomplete ('(((({<>}<{<{<>}{[]{[]{}') {
	ok(legal($incomplete), "input $incomplete is legal");
}
is(total_illegal_character_score(@test_input), 26397);

done_testing;