#!/usr/bin/perl 

use strict; 
use warnings; 
use 5.32.0; 
use List::Util qw(reduce);
use List::MoreUtils; 

my %open_to_close = split '', '()[]{}<>';

my %illegal_character_score = (
	')' => 3,
	']' => 57,
	'}' => 1197,
	'>' => 25137
);


sub legal {
	my ($input ) = @_;
	

	
	my @inputs = split '', $input;
	
	my @stack = ();
	my $valid_until_here = 1;
	my $additional_info = \@stack; 
	do {
		my $char = shift @inputs;
		if ( $char =~ /[({\[<]/ ) {
			push @stack, $char; 
		} elsif (@stack){
			my $previous = pop @stack; 
			$valid_until_here = "$previous$char" =~ /^(?:\(\)|\[\]|\{\}|<>)$/;
			if (!$valid_until_here) {
				$additional_info = {'expected' => $open_to_close{$previous}, 'found' => $char };
			}
		} else {
			return 0;
		}
	} while ($valid_until_here and scalar @inputs);
	
	return ($additional_info, $valid_until_here);
}

sub calculate_score {
	my ($input) = @_;
	
	return $illegal_character_score{$input->{'found'}};
}

sub total_illegal_character_score {
	
	return reduce {$a + $b} 
		map {my ($invalid) = legal($_); calculate_score($invalid)} 
		grep { !legal($_) } 
		@_;
	
}

sub autocomplete {
	my ($line) = @_;
		
	my ($stack, $result ) = legal($line);
	
	return map { $open_to_close{$_} } reverse(@$stack);
}

my %autocomplete_points = (
')' => 1,
']' => 2,
'}' => 3, 
'>' => 4
);

sub autocomplete_points {
	my (@closing_paranthesis ) = @_;
	
	return
		reduce{$a * 5 + $b}
		map {$autocomplete_points{$_}} @closing_paranthesis;
}

sub total_autocomplete_points {
	my (@inputs) = @_;
	my @scores = sort { $a <=> $b} 	
		map { autocomplete_points(autocomplete($_)) } 
		@inputs;
	my $winning_index = (scalar @scores - 1)  / 2;
	
	return $scores[$winning_index]; 
}

sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return split "\n", $result;
}

if (!caller(0)) {	
	my @input = getInput();
	my $illegal_score = total_illegal_character_score(@input);
	my $autocomplete_score = total_autocomplete_points(grep {legal($_)} @input);
	
	say "Illegal score sum: $illegal_score";
	say "Autocomplete score: $autocomplete_score";
	
	
}
1;

