#!/usr/bin/perl 

use strict; 
use warnings;
use List::Util qw(reduce);
use List::Compare;
use 5.32.0;

my %simple_outputs = (
	2 => 1,
	3 => 7,
	4 => 4,
	7 => 8,
);

my %digits = (
0 => {'top' => 1, 'top_left' => 1, 'top_right' => 1, 'middle' => 0, 'bottom_left' => 1, 'bottom_right' => 1, 'bottom' => 1},
1 => {'top' => 0, 'top_left' => 0, 'top_right' => 1, 'middle' => 0, 'bottom_left' => 0, 'bottom_right' => 1, 'bottom' => 0},
2 => {'top' => 1, 'top_left' => 0, 'top_right' => 1, 'middle' => 1, 'bottom_left' => 1, 'bottom_right' => 0, 'bottom' => 1},
3 => {'top' => 1, 'top_left' => 0, 'top_right' => 1, 'middle' => 1, 'bottom_left' => 0, 'bottom_right' => 1, 'bottom' => 1},
4 => {'top' => 0, 'top_left' => 1, 'top_right' => 1, 'middle' => 1, 'bottom_left' => 0, 'bottom_right' => 1, 'bottom' => 0},
5 => {'top' => 1, 'top_left' => 1, 'top_right' => 0, 'middle' => 1, 'bottom_left' => 0, 'bottom_right' => 1, 'bottom' => 1},
6 => {'top' => 1, 'top_left' => 1, 'top_right' => 0, 'middle' => 1, 'bottom_left' => 1, 'bottom_right' => 1, 'bottom' => 1},
7 => {'top' => 1, 'top_left' => 0, 'top_right' => 1, 'middle' => 0, 'bottom_left' => 0, 'bottom_right' => 1, 'bottom' => 0},
8 => {'top' => 1, 'top_left' => 1, 'top_right' => 1, 'middle' => 1, 'bottom_left' => 1, 'bottom_right' => 1, 'bottom' => 1},
9 => {'top' => 1, 'top_left' => 1, 'top_right' => 1, 'middle' => 1, 'bottom_left' => 0, 'bottom_right' => 1, 'bottom' => 1},
);

sub superposition {
	my @digits = @_;
	
	
	my %superpositioned = ();
	foreach my $part (keys %{$digits{0}}) {
		foreach my $candidate (@digits) {
			$superpositioned{$part} = $digits{$candidate}->{$part} + ($superpositioned{$part} // 0); 
		}
	}
	
	my %result;
	while (my ( $part, $value ) = each %superpositioned) {
		if ($value == 0 or $value == scalar @digits) {
			$result{$part} = $value;
		}
	}
	return %result;
}




sub splitInputOutput {
	my ($line) = @_;
	
	my @parts = split / \| /, $line; 
	
	return \@parts;
}

sub isSimpleDigit {
	my ($input) = @_;
	my $input_length = length($input);
	my $value = grep {$_ == length($input)} keys %simple_outputs;
	
	return $value;  
}

sub getUniqOutputDigits {
	my ($input) = @_;
	
	my $counter = 0; 
	foreach my $line (   
			map {split " ", splitInputOutput($_)->[1]} 
			split /\n/, $input
		) {
		$counter++ if (isSimpleDigit($line)); 
	}
	return $counter; 
}

sub mapping {
	my ($input) = @_;
	
	my %possibleConfigurations = (
	'top'          => ['a', 'b', 'c', 'd', 'e', 'f', 'g' ],
	'top_left'     => ['a', 'b', 'c', 'd', 'e', 'f', 'g' ], 
	'top_right'    => ['a', 'b', 'c', 'd', 'e', 'f', 'g' ],
	'middle'       => ['a', 'b', 'c', 'd', 'e', 'f', 'g' ], 
	'bottom_left'  => ['a', 'b', 'c', 'd', 'e', 'f', 'g' ], 
	'bottom_right' => ['a', 'b', 'c', 'd', 'e', 'f', 'g' ],
	'bottom'       => ['a', 'b', 'c', 'd', 'e', 'f', 'g' ], 
	);
	foreach my $item (split / (?:\| )?/, $input) {
		if (isSimpleDigit($item)) {
			my @activated_parts = split '', $item;
			my %should_be_active = %{$digits{$simple_outputs{length($item)}}};
			while (my ($key, $active) = (each %should_be_active)) {
				my $lc = List::Compare->new($possibleConfigurations{$key}, \@activated_parts);
				if ($active) {
					$possibleConfigurations{$key} = $lc->get_intersection_ref; 
				} else {
					$possibleConfigurations{$key} = $lc->get_unique_ref;
				}
				if (scalar @{$possibleConfigurations{$key}} == 1) {
					my $identified = $possibleConfigurations{$key};
					while (my ($configPart, $possibleValues) = each %possibleConfigurations ) {
						$lc = List::Compare->new($possibleConfigurations{$configPart}, $identified);
						$possibleConfigurations{$configPart} = $lc->get_unique_ref unless $key eq $configPart;
					}	
				}
				
			}
		}
	}
	foreach my $item (split / (?:\| )?/, $input) {
		my @activatedParts = split '', $item;
		my %superposition; 
		if (length($item) == 5) {
			%superposition = superposition(2,3,5);
		} elsif (length($item) == 6) {
			%superposition = superposition(0,6,9);
		} else {
			%superposition = %{$digits{$simple_outputs{length($item)}}};
		}
		if (scalar %superposition) {
			while (my ($key, $active) = (each %superposition )) {					
				my $lc = List::Compare->new($possibleConfigurations{$key}, \@activatedParts);
				if ($active) {
					$possibleConfigurations{$key} = $lc->get_intersection_ref;
				} else {
					$possibleConfigurations{$key} = $lc->get_unique_ref;
				}
				if (scalar @{$possibleConfigurations{$key}} == 1) {
					my $identified = $possibleConfigurations{$key};
					while (my ($configPart, $possibleValues) = each %possibleConfigurations ) {
						$lc = List::Compare->new($possibleConfigurations{$configPart}, $identified);
						$possibleConfigurations{$configPart} = $lc->get_unique_ref unless $key eq $configPart;
					}	
				}
			}
		}
	}
	my %result; 
	while (my ($part, $config) = each %possibleConfigurations) {
		$result{$part} = ${$config}[0];
	} 
	
	
	return \%result;
}

sub normalize {
	my ($input) = @_;
	return join '', 
	sort 
	split '', $input;
}

sub mapped_digits {
	my ($mapping) = @_;
	
	my %encoded = ();
	
	while (my ($digit, $configuration) = each %digits) {
		my @active_lines = ();
		while (my ($part, $active) = each %$configuration) {
			push @active_lines, $mapping->{$part} if $active;
		}
		$encoded{$digit} = join '', 
			sort {$a cmp $b}
			@active_lines;
	}
	
	return \%encoded;
}

sub getOutputValue($) {
	my ($input) = @_;
	
	my %mapping = reverse %{mapped_digits(mapping($input))};
	
	return reduce {$a * 10 + $b}
	map { $mapping{normalize($_)} }
	split ' ', splitInputOutput($input)->[1];
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
	my $solutionPart1 = getUniqOutputDigits($input);
	my $sum_output =
		reduce {$a + $b }
		map {getOutputValue($_)} 
		split "\n", $input;
	say "Solution to part 1 should be $solutionPart1";
	say "solution to part 2 should be $sum_output";

	
}

1;