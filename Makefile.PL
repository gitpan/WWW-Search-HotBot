use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
              'NAME' => 'WWW::Search::HotBot',
              'VERSION_FROM' => 'HotBot.pm',
              'PREREQ_PM' => {
                              'WWW::Search' => 2.09,
                             },
);

sub MY::postamble
  {
  return '
update: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERL) -I$(INST_ARCHLIB) -I$(INST_LIB) update HotBot
';
  } # MY::postamble
