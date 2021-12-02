#!/usr/bin/perl 

use 5.32.0;
use warnings; 
use strict;
no warnings 'experimental';


sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}

sub navigate($) {
	my ($instructions) = @_;
	
	my ($forward_pos, $depth ) = (0,0);
	foreach my $instruction  ( split /\n/, $instructions ) {
		my ($instruction_type, $argument) =   $instruction =~ /(\w+) (\d+)/ ;
		given ($instruction_type) {
			when ($_ eq 'forward') {
				$forward_pos += $argument;
			}
			when ($_ eq 'up') {
				$depth -= $argument;
			}
			when ($_ eq 'down' ) {
				$depth += $argument;
			}
			default {
				die "no such instruction $instruction_type";
			}
		} 
	}
	return ($forward_pos, $depth);
}

if (!caller(0)) {
	my ($forward, $depth) = navigate(getInput());
	my $solution = $forward *  $depth;
	say "Forward Position is $forward, depth is $depth. Solution result should be $solution";
}

1;