#!/volume/perl/bin/perl
use warnings;
use strict;
use vars qw($VERSION);
use lib qw(/volume/labtools/lib /homes/nnaveenkumar/project2);

use JT;
use JT::Test;
use ConfigurePingTest;

$VERSION = do { my @r = (q$Revision: 1.0 $ =~ /\d+/g); sprintf "%d."."%02d" x $#r, @r };

main: {
    my $t = JT::Test->init;
    $t->setup;
    $t->run_testcases;
    $t->close;
}

