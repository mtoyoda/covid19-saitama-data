use strict;
use warnings;
use utf8;
use Encode;

binmode STDOUT, "encoding(utf8)";

my %date_district_num = ();
my %districts = ();

my ($num, $err) = (0, 0);

my $line = <STDIN>;
while (my $line = <STDIN>) {
    chomp $line;
    $line = decode_utf8($line);
    my ($no, $date, $age, $sex, $district) = split /,/, $line;
    if (($date =~ m#^(\d+)/(\d+)/(\d+)#) && $district ne "") {
	$date = sprintf("%04d/%02d/%02d", $1, $2, $3);
	$date_district_num{$date}->{$district} += 1;
	$districts{$district} += 1;
	++$num;
    }
    else {
	++$err;
	#print STDERR "$line\n";
    }
}
print STDERR "Num: $num, Error: $err\n";

my @districts_sorted = sort {$districts{$b} <=> $districts{$a}} keys(%districts);

print "Date";
for my $dist (@districts_sorted) {
    print ",$dist";
}
print "\n";

for my $date (sort(keys(%date_district_num))) {
    print "$date";
    for my $d (@districts_sorted) {
	my $num = $date_district_num{$date}->{$d};
	if (!defined $num) { $num = 0; }
	print ",$num";
    }
    print "\n";
}

