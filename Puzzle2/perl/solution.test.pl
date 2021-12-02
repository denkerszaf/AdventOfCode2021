#!/usr/bin/perl

use strict; 
use warnings; 
use Test::Simple tests => 1;
use 5.32.0;

require "solution.pl";

my $example_instructions = <<INSTRUCTIONS;
forward 5
down 5
forward 8
up 3
down 8
forward 2
INSTRUCTIONS


ok navigate($example_instructions) == (15, 10); 