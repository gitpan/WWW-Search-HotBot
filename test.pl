# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

use ExtUtils::testlib;
use WWW::Search::Test qw( new_engine run_gui_test run_test skip_test );

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..8\n"; }
END {print "not ok 1\n" unless $loaded;}
use WWW::Search::HotBot;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

$WWW::Search::Test::iTest = 1;

&new_engine('HotBot');

# goto GUI_TEST;
# goto MULTI_TEST;
my $debug = 0;

# This test returns no results (but we should not get an HTTP error):
&run_test($WWW::Search::Test::bogus_query, 0, 0, $debug);
# This query returns 1 page of results:
&run_test('+LS'.'AM +repl'.'ication +cor'.'e', 1, 99, $debug);

# goto GUI_TEST;

MULTI_TEST:
&skip_test; goto GUI_TEST;
# This query returns MANY pages of results:
&run_test('"Bo'.'ss Na'.'ss"', 101, undef, $debug);

GUI_TEST:

# This query returns 1 page of results:
&run_gui_test('Ma'.'rtin AND Thu'.'rn AND Bi'.'ble AND Galo'.'ob', undef, 10, $debug);
# This query returns 3 pages of results:
&skip_test; goto GUI_TEST3;
&run_gui_test('ctil'.'etou', 31, 40, $debug);
GUI_TEST3:
# This query returns many pages of results:
&skip_test; goto GUI_TEST4;
&run_gui_test('Jar Jar must die', 31, 40, $debug);
GUI_TEST4:

__END__

