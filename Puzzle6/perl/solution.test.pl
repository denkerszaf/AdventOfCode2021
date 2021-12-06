#!/usr/bin/perl

use Test::More;
use strict; 
use warnings; 
use 5.32.0;

require "solution.pl";

is_deeply( nextGeneration(histogram('3,4,3,1,2')), histogram('2,3,2,0,1'));
is_deeply( nextGeneration(histogram('2,3,2,0,1')), histogram('1,2,1,6,8,0'));
is( fishCount(histogram('2,3,2,0,1')), 5);
is_deeply( generations('3,4,3,1,2', 2), histogram('1,2,1,6,8,0'));
is( fishCount(generations("3,4,3,1,2", 80)), 5934);
is( fishCount(generations("3,4,3,1,2", 256)), 26984457539);
done_testing();
1;
