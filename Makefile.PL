use inc::Module::Install;

name('WWW-Search-HotBot');
version_from('HotBot.pm');
author('Martin Thurn <mthurn@cpan.org>');
license('perl');

requires('perl' => 5.004);
requires('WWW::Search::Test' => 2.16);
# Test::More is needed for `make test`:
include_deps('Test::More', 5.004);
build_requires('Test::More');

check_nmake();      # check and download nmake.exe for Win32
&Makefile->write;

1;

__END__
