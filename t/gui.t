
use ExtUtils::testlib;

use Test::More no_plan;

BEGIN { use_ok('WWW::Search') };
BEGIN { use_ok('WWW::Search::Test', qw( count_results )) };
BEGIN { use_ok('WWW::Search::HotBot') };

&my_engine('HotBot');

my $iDebug = 0;
my $iCount;

$iDebug = 0;
# This test returns no results (but we should not get an HTTP error):
&my_test('gui', $WWW::Search::Test::bogus_query, 0, 0, $iDebug);
$iDebug = 0;
# This query returns 1 page of results:
&my_test('gui', 'Ma'.'rtin AND Thu'.'rn AND Bi'.'ble AND Galo'.'ob', 1, 10, $iDebug);
$iDebug = 0;
# This query returns many pages of results:
&my_test('gui', 'Star Wars Collector Bible', 21, undef, $iDebug);

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

