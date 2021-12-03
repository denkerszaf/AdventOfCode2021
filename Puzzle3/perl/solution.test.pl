#!/usr/bin/perl

use strict; 
use warnings; 
use Test::Simple tests => 4;
use 5.32.0;

require "solution.pl";

my $diagnostic_report = <<REPORT;
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
REPORT

ok extractGamma(analyzeReport($diagnostic_report)) == 22;
ok extractEpsilon(analyzeReport($diagnostic_report)) == 9;
ok extractOxygenRating($diagnostic_report) == 23;
ok extractCO2ScrubberRating($diagnostic_report) == 10;