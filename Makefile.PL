use ExtUtils::MakeMaker;
WriteMakefile(
              'NAME' => 'WWW::Search::HotBot',
              'VERSION_FROM' => 'HotBot.pm',
              'PREREQ_PM' => {
                              'Test::More' => 0,
                              'WWW::Search::Test' => 2.16,
                             },
             );
