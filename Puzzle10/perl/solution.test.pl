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

# Part 2
#while (my ($input, $completion) = each (
#    '[({(<(())[]>[[{[]{<()<>>' => split '', '}}]])})]',
#    '[(()[<>])]({[<{<<[]>>(' => split '', ')}>]})',
#    '(((({<>}<{<{<>}{[]{[]{}' => split '', '}}>}>))))',
#    '{<[[]]>}<{[{[{[]{()[[[]' => split '', ']]}}]}]}>',
#    '<{([{{}}[<[[[<>{}]]]>[]]' => split '', '])}>'
#		)
#	) {
	is_deeply(
	[ autocomplete('[({(<(())[]>[[{[]{<()<>>') ], [split '', '}}]])})]'] );	
#}

is(total_autocomplete_points(grep {legal($_)} @test_input), 288957);


done_testing;