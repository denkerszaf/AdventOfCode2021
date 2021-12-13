#!/usr/bin/perl

use strict; 
use warnings; 
use 5.32.0;
use List::Util qw(reduce max min);

sub parse_input ($) {
	my ($input) = @_;
	
	my ($dots, $instructions ) = split /\n\n/, $input;
	
	my @matrix = map {[split ',', $_]} split /\n/, $dots;
	my @instructions = map { 
		my ($o, $l) = ( $_ =~ m/([xy])=(\d+)$/ ); 
		{'fold_direction' => $o, 'fold_position' => $l} 
	} split /\n/, $instructions; 
	
	return {'dot_matrix' => \@matrix, 'folding_instructions' => \@instructions};  
}

sub uniq_points {
        my (@points) = @_;
        
        my %temp = map { $_->[0] . ',' . $_->[1] => $_ } @points;
        
        return values %temp;
}


sub fold_paper($) {
	my ($input) = @_;
	
	my $instruction = shift @{$input->{'folding_instructions'}};
	my $folding_dimension = $instruction->{'fold_direction'} eq 'y' ? 1 : 0; 
	my $max_index = reduce { max($a, $b) } map { $_->[$folding_dimension] } @{$input->{'dot_matrix'}};
	
	my @new_dot_matrix = sort { $a->[0] <=> $b->[0] ? $a->[0] <=> $b->[0]: $a->[1] <=> $b->[1] } (uniq_points(map {
		my $r = [ $_->[0], $_->[1] ];
		if ($_->[$folding_dimension] > $instruction->{'fold_position'}) { 
			$r->[1-$folding_dimension] = $_->[1-$folding_dimension]; 
			$r->[$folding_dimension] = 
				# $max_index - $_->[$folding_dimension];
				 2 *  $instruction->{'fold_position'} - $r->[$folding_dimension];
			
		} 
		$r  }
		 @{$input->{'dot_matrix'}})
	);
	
	my $min_index = reduce { min($a, $b) } map { $_->[$folding_dimension] } @new_dot_matrix;
	@new_dot_matrix = map { my $r = $_; $r->[$folding_dimension] -= $min_index ; $r} @new_dot_matrix if $min_index < 0;
	
	$input->{'dot_matrix'} = \@new_dot_matrix;
	
	return $input;
}

sub to_diagram {
	my (@dot_matrix) = @_;
	
	my $max = reduce { [ max($a->[0], $b->[0]),max($a->[1], $b->[1]) ]  } @dot_matrix;
	
	
	my @output = ();
	for (my  $i = 0; $i <= $max->[1]; $i++) {
				 $output[$i] = [ map {'.'}(0..$max->[0]) ];
	}
	
	foreach my $p (@dot_matrix) {
		$output[$p->[1]]->[$p->[0]] = "#";
	}
	
	return reduce { "$a\n$b"  }  map { join '',  @$_ } @output;
	
}

sub complete_instructions {
	my ($output) = @_;

	while ( scalar @{$output->{'folding_instructions'}}) {
		$output = fold_paper($output);
	}
	
	return $output;
}


sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}


if (!caller(0)) {
	my $input = parse_input(getInput());
	
	my $output = fold_paper($input);
	say "dotcount: " . scalar @{$output->{'dot_matrix'}};
	while ( scalar @{$output->{'folding_instructions'}}) {
		$output = fold_paper($output);
	}
	say to_diagram(@{$output->{'dot_matrix'}});
}

1; 