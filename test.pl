# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

use ExtUtils::testlib;

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

my $iTest = 2;

my $sEngine = 'HotBot';
my $oSearch = new WWW::Search($sEngine);
print ref($oSearch) ? '' : 'not ';
print "ok $iTest\n";

use WWW::Search::Test;

# goto GUI_TEST;
# goto MULTI_TEST;
my $debug = 0;

# This test returns no results (but we should not get an HTTP error):
$iTest++;
$oSearch->native_query($WWW::Search::Test::bogus_query);
@aoResults = $oSearch->results();
$iResults = scalar(@aoResults);
print STDOUT (0 < $iResults) ? 'not ' : '';
print "ok $iTest\n";
print STDERR "\n\n\n\n" if $debug;

# This query returns 1 page of results:
$iTest++;
my $sQuery = '+LS'.'AM +repl'.'ication +cor'.'e';
$oSearch->native_query(
                       WWW::Search::escape_query($sQuery),
                         { 'search_debug' => $debug, },
                      );
@aoResults = $oSearch->results();
$iResults = scalar(@aoResults);
# print STDERR " + got $iResults results for $sQuery\n";
if (($iResults < 2) || (49 < $iResults))
  {
  print STDERR " --- got $iResults results for $sQuery, but expected 2..49\n";
  print STDOUT 'not ';
  }
print "ok $iTest\n";
print STDERR "\n\n\n\n" if $debug;

# goto GUI_TEST;

MULTI_TEST:
# This query returns MANY pages of results:
$iTest++;
$sQuery = '"Bo'.'ss Na'.'ss"';
$oSearch->native_query(
                       WWW::Search::escape_query($sQuery),
                      { 'search_debug' => $debug, },
                      );
$oSearch->maximum_to_retrieve(149); # 3 pages
@aoResults = $oSearch->results();
$iResults = scalar(@aoResults);
# print STDERR " + got $iResults results for Bos","s Na","ss\n";
if (($iResults < 101))
  {
  print STDERR " --- got $iResults results for $sQuery, but expected 101..\n";
  print STDOUT 'not ';
  }
print "ok $iTest\n";
print STDERR "\n\n\n\n" if $debug;

GUI_TEST:
# This query returns 1 page of results:
$iTest++;
# $debug = 9;
$sQuery = 'Ma'.'rtin AND Thu'.'rn AND Bi'.'ble AND Galo'.'ob';
$oSearch->gui_query(
                    WWW::Search::escape_query($sQuery),
                      { 'search_debug' => $debug, },
                   );
$oSearch->maximum_to_retrieve(20);
@aoResults = $oSearch->results();
$iResults = scalar(@aoResults);
print STDERR " + got $iResults GUI results for $sQuery, expected 1..10\n" if $debug;
if (($iResults < 1) || (10 < $iResults))
  {
  print STDERR " --- got $iResults GUI results for $sQuery, but expected 1..10\n";
  print STDOUT 'not ';
  }
print "ok $iTest\n";

# This query returns 3 pages of results:
$iTest++;
# $debug = 9;
$sQuery = 'ctil'.'etou';
$oSearch->gui_query(
                    WWW::Search::escape_query($sQuery),
                      { 'search_debug' => $debug, },
                   );
$oSearch->maximum_to_retrieve(40);
@aoResults = $oSearch->results();
$iResults = scalar(@aoResults);
print STDERR " + got $iResults GUI results for $sQuery, expected 21..30\n" if $debug;
if (($iResults < 21) || (30 < $iResults))
  {
  print STDERR " --- got $iResults GUI results for $sQuery, but expected 21..30\n";
  print STDOUT 'not ';
  }
print "ok $iTest\n";

# This query returns many pages of results:
$iTest++;
# $debug = 9;
$sQuery = 'Jar Jar must die';
$oSearch->gui_query(
                    WWW::Search::escape_query($sQuery),
                      { 'search_debug' => $debug, },
                   );
$oSearch->maximum_to_retrieve(30);
@aoResults = $oSearch->results();
$iResults = scalar(@aoResults);
print STDERR " + got $iResults GUI results for $sQuery, expected 30..\n" if $debug;
if ($iResults < 30)
  {
  print STDERR " --- got $iResults GUI results for $sQuery, but expected 30..\n";
  print STDOUT 'not ';
  }
print "ok $iTest\n";

__END__

