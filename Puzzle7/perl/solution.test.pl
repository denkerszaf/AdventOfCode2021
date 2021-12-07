#!/usr/bin/perl 

use Test::More;
use strict; 
use warnings; 
use 5.32.0;

require 'solution.pl';

is_deeply(\optimalPosition('16,1,2,0,4,2,7,1,2,14'), [5, 168] );

1;