#!/usr/bin/perl

use strict;
use warnings; 
use 5.32.0;
use Test::More;

require_ok('solution.pl');

my $example_input = <<INPUT;
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
INPUT

is(getUniqOutputDigits($example_input), 26);
is_deeply(mapping("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"), {
	'top' => 'd',
	'top_left' => 'e', 
	'top_right' => 'a',
	'middle' => 'f', 
	'bottom_left' => 'g', 
	'bottom_right' => 'b',
	'bottom' => 'c', 
	}
);

is(getOutputValue("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"), 5353);

is_deeply(mapped_digits({
	'top' => 'd',
	'top_left' => 'e', 
	'top_right' => 'a',
	'middle' => 'f', 
	'bottom_left' => 'g', 
	'bottom_right' => 'b',
	'bottom' => 'c', 
	}), {
		0 => 'abcdeg',
		1 => 'ab',
		2 => normalize('gcdfa'),
		3 => normalize('fbcad'),
		4 => normalize('eafb'),
		5 => normalize('cdfbe'),
		6 => normalize('cdfgeb'),
		7 => 'abd',
		8 => normalize('acedgfb'),
		9 => normalize('cefabd'),
	} );

done_testing; 
