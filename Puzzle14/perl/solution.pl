#!/usr/bin/perl

use strict; 
use warnings; 
use 5.32.0;
use List::Util qw(reduce);

sub parse_input {
	my ($input) = @_;
	
	my @lines = split "\n\n", $input;
	
	my @rules = split "\n", $lines[1];
	
	my %ruleset = ();
	foreach my $rule (@rules) {
		my ($string, $subst) =  ($rule =~ /(\w+)\s*->\s*(\w+)/);
		$ruleset{$string} = $subst;
	}
	
	return {'template' => $lines[0], 'rules' => \%ruleset};
	
	
}

sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}

sub polymerize {
	my ($input) = @_;
	
	 my $new_template = reduce {
	 	$a . $input->{'rules'}->{substr($a, -1, 1) . $b } . $b 
	 }
	 split '', $input->{'template'};
	 
	 return {'template' => $new_template, 'rules' => $input->{'rules'}};
}


if (!caller(0)) {	
}

1; 