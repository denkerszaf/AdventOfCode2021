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

sub multistep_rules {
	my ($template, $rules, $steps) = @_;
	
	
	
}

sub polymerize_histogram {
	my ($items, $rules, $generations, $cache) = @_;
	
	if ($generations > 0) {
		my $histogram = {};
		foreach my $index (0.. scalar @$items -2) {
			my $first = $items->[$index];
			my $last  = $items->[$index +1];
			my $prod = $rules->{$first . $last};
			my $prod_histogram = $cache->{"$first$last,$generations"} // polymerize_histogram([$first, $prod, $last], $rules, $generations - 1, $cache) ;
			$cache->{"$first$last,$generations"} = $prod_histogram;
			$histogram = merge_histograms($histogram, $prod_histogram);
			$histogram->{$last} -= 1 unless $index == scalar @$items -2;
		}
		return $histogram;
	}
	return histogram(@$items);
}

sub polymerize_only_histogram {
	my ($input, $steps) = @_;
	$steps //= 1; 
	
	return polymerize_histogram([split '', $input->{'template'}], $input->{'rules'}, $steps);
}


sub polymerize {
	my ($input, $steps) = @_;
	$steps //= 1;
	
	
	my $new_template = $input->{'template'};
	foreach (1..$steps) {
	$new_template = reduce {
	 	$a . $input->{'rules'}->{substr($a, -1, 1) . $b } . $b 
	}
	split '', $new_template;
	}
	 
	return {'template' => $new_template, 'rules' => $input->{'rules'}};
}

sub histogram {
	my (@template) = @_;
	
	my %histogram = ();
	foreach my $char (@template) {
		$histogram{$char} = ( $histogram{$char} //  0 ) + 1 ; 
	}
	
	return \%histogram;
}

sub merge_histograms {
	my ($a, $b) = @_;
	
	my $result = {};
	foreach my $key ( keys %$a, keys %$b) {
		$result->{$key} = ($a->{$key} // 0 ) + ($b->{$key} // 0 ) ;
	}
	
	return $result;
}

sub solve {
	my ($histogram) = @_;
	
	my @values = sort {$b <=> $a } values %$histogram;
	return $values[0] - $values[-1];
}


if (!caller(0)) {
	say " solution to part 1 is " . solve(polymerize_only_histogram(parse_input(getInput()),10));
	say " solution to part 1 is " . solve(polymerize_only_histogram(parse_input(getInput()),40));
		
}

1; 