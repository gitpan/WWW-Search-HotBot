use ExtUtils::MakeMaker;
WriteMakefile(
              'NAME' => 'WWW::Search::HotBot',
              'VERSION_FROM' => 'HotBot.pm',
              'PREREQ_PM' => {
                              'WWW::Search::Test' => 2.16,
                             },
             );
