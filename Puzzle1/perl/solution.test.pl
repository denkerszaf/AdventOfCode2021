#!/usr/bin/perl

use strict; 
use warnings; 
use Test::Simple tests => 2;
use 5.32.0;

require "solution.pl";

ok 1==1;
ok getIncreasedDepths(199,200 ,208 ,210 ,200 ,207 ,240 ,269 ,260 ,263) == 7;
# ok getIncreasedWindows(199,200 ,208 ,210 ,200 ,207 ,240 ,269 ,260 ,263) == 7;

