#!/usr/bin/perl

#### Usage ####
# cd to/folder_where_unihan.pl_is_located/
# perl unihan.pl
################

use strict;
use warnings;
use FindBin qw/$Bin/;

my $start = time;
my $now_string = localtime;
print "Start : $now_string\n";
my %data; my @u;

# First file: Unihan_readings.txt
open(my $fh, '<:utf8', "input/Unihan_Readings.txt") or die $!;
while (<$fh>) {
    next if (/\^#/);
    if (/^(\S+)\s+(kCantonese|kHanyuPinyin)\s+(.+)$/) {
        my $sym = $1; my $type = $2; my $v = $3;
        if ($type eq 'kHanyuPinyin') {
            # U+34D8	kHanyuPinyin	10278.080,10278.090:su
            # U+20088	kHanyuPinyin	10049.040:jie 10049.050:tin
            $v =~ s/(^|\s+)[\:\d\.\,]+/$1/g;
        }
        $v =~ s/\s+/\,/g;
        $data{$sym}{$type} = $v;
    }
    if (/^(U\+\S+)\s+/) {
        push @u, $1;
    }
}
close($fh);

# Second file: Unihan_DictionaryLikeData.txt
open($fh, '<:utf8', "input/Unihan_DictionaryLikeData.txt") or die $!;
while (<$fh>) {
    next if (/\^#/);
    if (/^(\S+)\s+(kFrequency|kCangjie)\s+(.+)$/) {
        my $sym = $1; my $type = $2; my $v = $3;
        $data{$sym}{$type} = $v;
    }
    if (/^(U\+\S+)\s+/) {
        push @u, $1;
    }
}
close($fh);

my %dups;
open(my $out, '>:utf8', "output/output.txt");
foreach my $u (@u) {
    next if $dups{$u}; $dups{$u} = 1;
    # Unicode kFrequency kCangjie kHanyuPinyin kCantonese
    print $out join("\t", $u, $data{$u}{kFrequency} || 0, $data{$u}{kCangjie} || '', $data{$u}{kHanyuPinyin} || '', $data{$u}{kCantonese} || '') . "\n";
}
close($fh);

my $duration = time - $start;
$now_string = localtime;
print "Finish: $now_string\n";
print "Execution time: $duration secs\n";

1;