
use ExtUtils::testlib;

use Test::More no_plan;

BEGIN { use_ok('WWW::Search') };
BEGIN { use_ok('WWW::Search::Test', qw( count_results )) };
BEGIN { use_ok('WWW::Search::HotBot') };

&my_engine('HotBot');

my $iDebug = 0;
my $iDump = 0;
my $iCount;

# goto TEST_NOW;
$iDebug = 0;
# This test returns no results (but we should not get an HTTP error):
&my_test('normal', $WWW::Search::Test::bogus_query, 0, 0, $iDebug);
TEST_NOW:
$iDebug = 0;
$iDump = 0;
# This query returns 1 page of results:
&my_test('normal', 'trans'.'morgify', 1, 99, $iDebug, $iDump);
# exit 88;
my @ao = $WWW::Search::Test::oSearch->results();
cmp_ok(0, '<=', scalar(@ao), 'got any results');
foreach my $oResult (@ao)
  {
  like($oResult->url, qr{\Ahttp://},
       'result URL is http');
  cmp_ok($oResult->title, 'ne', '',
         'result Title is not empty');
  cmp_ok($oResult->description, 'ne', '',
         'result description is not empty');
  cmp_ok($oResult->change_date, 'ne', '',
         'result change_date is not empty');
  cmp_ok(0, '<', $oResult->size,
         'result size is not zero');
  } # foreach
$iDebug = 0;
# This query returns many pages of results:
&my_test('normal', 'Sta'.'r Wa'.'rs', 102, undef, $iDebug);

exit 0;

sub my_engine
  {
  my $sEngine = shift;
  $WWW::Search::Test::oSearch = new WWW::Search($sEngine);
  ok(ref($WWW::Search::Test::oSearch), "instantiate WWW::Search::$sEngine object");
  $WWW::Search::Test::oSearch->env_proxy('yes');
  } # my_engine

sub my_test
  {
  # Same arguments as WWW::Search::Test::count_results()
  my ($sType, $sQuery, $iMin, $iMax, $iDebug, $iPrintResults) = @_;
  my $iCount = &count_results(@_);
  cmp_ok($iMin, '<=', $iCount, qq{lower-bound num-hits for query=$sQuery}) if defined $iMin;
  cmp_ok($iCount, '<=', $iMax, qq{upper-bound num-hits for query=$sQuery}) if defined $iMax;
  } # my_test

__END__

