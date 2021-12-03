#!/usr/bin/perl 

use 5.32.0;
use warnings; 
use strict;
use List::Util qw( max );

sub analyzeReport {	
	my ($report) = @_;
	
	my ($current_column, $rowcount, $column_count) = (0,0);
	
	my %bitcount = ();
	
	foreach my $bit (split '',$report) {
		if ($bit eq "\n") {
			($current_column, $rowcount, $column_count ) = (0, $rowcount +1, $current_column -1 );
		} else {
			$bitcount{$current_column++} +=$bit
		}	
	}
	
	my %result;
	while (my ( $column, $onesCount) = each %bitcount) {
		$result{$column} = $onesCount >= $rowcount / 2 ? 1 : 0;	
	}
	
	return %result;
	
}


sub extractGamma {
	my (%report_analysis) = @_;
	
	my $column_count = max (keys %report_analysis );
	my $gamma = 0;
	
	while (my ( $column, $value) = each %report_analysis) {
			my $valueToAdd = $value * 2**($column_count - $column ); 
			$gamma += $valueToAdd;
		 
	}
	
	return $gamma;
}

sub extractEpsilon {
	my (%report_analysis) = @_;

	my $gamma = extractGamma(%report_analysis);
	my $column_count = max (keys  %report_analysis);
		
	return  (2**($column_count+1)-1) ^ $gamma;
	 	
}



sub getSolution {
	my %prevailingValues = analyzeReport(@_);

	
	my $gamma = extractGamma(%prevailingValues);	
		
	my $epsilon = extractEpsilon(%prevailingValues); 
	
	return ($gamma, $epsilon);
	
}

sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}


if (!caller(0)) {
	my ($gamma, $epsilon) = getSolution(getInput());
	
	say "Gamma value $gamma, epsilon value $epsilon, puzzle solution is " . $gamma * $epsilon;
		
}

1;