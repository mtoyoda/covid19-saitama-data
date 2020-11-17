use strict;
use warnings;

while (my $line = <STDIN>) {
    if ($line =~ m#href="(https://.*.csv)"#) {
	print "$1\n";
    }
}
