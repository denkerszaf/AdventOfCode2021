#!/usr/bin/perl

use strict; 
use warnings;
use List::MoreUtils qw(any uniq duplicates);
use List::Util qw /sum/;
use 5.32.0;

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub parseInput {
	my ($input) = @_;
	
	my @parts = split "\n\n", $input;
	
	my $draws = [ split /,/, shift @parts ];
	
	my @boards;
	foreach my $board (@parts) {
		my @lines = split /\n/, $board; 
		my @board = map { [ split / +/ , trim($_) ] } @lines;
		push @boards, \@board;
	}
	
	return {
		'draws' => $draws,
		'boards' => \@boards,
	}
}

sub isWinner {
	my ($drawn, $board) = @_; 
	
	my @marked_rows; 
	my @marked_columns; 
	
	for (my $row = 0; $row < scalar @$board; $row++) {
		for (my $column = 0; $column < scalar @{$board->[$row]}; $column++) {
			my $value = $board->[$row]->[$column];
			if (any {$_ == $value } @$drawn) {
				$marked_rows[$row] = 1 + ($marked_rows[$row] // 0 );
				$marked_columns[$column] = 1 + ($marked_columns[$column] // 0);
			}
		}
	}
	my $element = scalar @$board;
	return any {$_ >= ($element // 0) } map { $_ // 0 } (@marked_columns, @marked_rows );
}

sub getWinners {
	my ($drawn, $boards) =  @_;
	
	my @winners; 
	for (my $i = 0; $i < scalar @$boards; $i++) {
		if (isWinner($drawn, $boards->[$i])) {
			push @winners, $i;
		} 
	}
	
	return @winners; 
}

sub winningBoard {
	my ($input) = @_;
	
	my @drawn = ();
	my @winners = ();

	do {
		push @drawn, (shift @{$input->{'draws'}});
		@winners = getWinners(\@drawn, $input->{'boards'});
		
	} while ((scalar @winners == 0) and (scalar @{$input->{'draws'}}));
	
	return (\@winners, \@drawn);
}

sub score {
	my ($board, $drawn) = @_;
	
	my @numbers_on_board =  map {@$_} @$board;
	
	my $sum_of_numbers = sum @numbers_on_board;
	my $sum_of_drawn = sum( duplicates (@numbers_on_board, @$drawn)) // 0;
	
	my $sum_of_unmarked = $sum_of_numbers - $sum_of_drawn;
	
	return $sum_of_unmarked * $$drawn[-1];
}


sub getInput() {
	open (my $fh, '<', '../input') or die 'could not read input';
	$/ = undef;
	my $result = <$fh>;
	close($fh);
	return $result;
}


if (!caller(0)) {
	my $input = parseInput(getInput());
	my ($winners, $drawn) = winningBoard($input);
	my $winner = $winners->[0];
	
	my $score = score($input->{'boards'}->[$winner], $drawn);
	 
	say "winner is board $winner with a score of $score";
	
}

1;


1;