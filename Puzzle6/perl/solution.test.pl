#!/usr/bin/perl

use Test::More;
use strict; 
use warnings; 
use 5.32.0;

require "solution.pl";

is( nextGeneration('3,4,3,1,2'), '2,3,2,0,1');
is(  nextGeneration('2,3,2,0,1'), '1,2,1,6,8,0');
is( fishCount('2,3,2,0,1'), 5);
is( generations('3,4,3,1,2', 2), '1,2,1,6,8,0');
is( fishCount(generations("3,4,3,1,2", 80)), 5934);
done_testing();
1;
