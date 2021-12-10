#!/usr/bin/perl 

use strict; 
use warnings; 
use 5.32.0; 
use List::Util qw(reduce);
use List::MoreUtils; 

sub legal {
	my ($input) = @_;
	
	my @inputs = split '', $input;
	
	my @stack =();
	my $valid_until_here = 1;
	my $index = 0;
	do {
		my $char = shift @inputs;
		if ( $char =~ /[({\[<]/ ) {
			push @stack, $char; 
		} elsif (@stack){
			my $previous = pop @stack; 
			$valid_until_here = "$previous$char" =~ /^(?:\(\)|\[\]|\{\}|<>)$/;
		} else {
			return 0;
		}
	} while ($valid_until_here and scalar @inputs);
	
	return $valid_until_here;
}

1;

