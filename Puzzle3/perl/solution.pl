#!/usr/bin/perl 

use 5.32.0;
use warnings; 
use strict;
use List::Util qw( max );

sub analyzeReport {	
	my ($report) = @_;
	
	my ($current_column, $column_count) = (0,0);
	
	my $rowcount = scalar split /\n/, $report;  
	
	my %bitcount = ();
	
	foreach my $bit (split '',$report) {
		if ($bit eq "\n") {
			($current_column, $column_count ) = (0, $current_column -1 );
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

sub binaryStringToInt {
	my ($bitstring) = @_;
	 
	my $result = 0; 
	
	foreach my $bit ( split '', $bitstring) {
		$result = 2 * $result + $bit;
	}
	
	return $result;
}

sub extractEpsilon {
	my (%report_analysis) = @_;

	my $gamma = extractGamma(%report_analysis);
	my $column_count = max (keys  %report_analysis);
		
	return  (2**($column_count+1)-1) ^ $gamma;
 	
}


sub extractOxygenRating {
	my ($report) = @_;
	
	my $column = 0;
	while ($report =~ /\n/) {
		my %report_analysis = analyzeReport($report);
		my $current_column = $column++; 
		$report = join "\n", grep { $report_analysis{$current_column} == (split '', $_)[$current_column]} split /\n/, $report;
	}
	return binaryStringToInt($report);
}

sub extractCO2ScrubberRating {
	my ($report) = @_;
	
	my $column = 0;
	while ($report =~ /\n/) {
		my %report_analysis = analyzeReport($report);
		my $current_column = $column++; 
		$report = join "\n", grep { $report_analysis{$current_column} != (split '', $_)[$current_column]} split /\n/, $report;
	}
	return binaryStringToInt($report);
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
	my $input = getInput();
	my ($gamma, $epsilon) = getSolution($input);
	my ($oxygen, $scrubber) = ( extractOxygenRating($input), extractCO2ScrubberRating($input));
	
	say "Gamma value $gamma, epsilon value $epsilon, puzzle solution is " . $gamma * $epsilon;
	say "Oxygen value is $oxygen, c02 value is $scrubber, puzzle solution is " . $oxygen * $scrubber;
		
}

1;