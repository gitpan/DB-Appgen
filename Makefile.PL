use ExtUtils::MakeMaker;
#######################################################################################
# Put your appgen library here (see README for details)
#
my $appgenlibdir='/home/am/src/appgen/lib';
#
# That's all you need to change.
#######################################################################################
while(! -x $appgenlibdir || ! -r "$appgenlibdir/libappgen_appl.a"
                         || ! -r "$appgenlibdir/libappgen_strings.a"
                         || ! -r "$appgenlibdir/libappgen.a")
{ print <<EOT;
You did not set up APPGEN library correctly. Please read README
and follow instructions. The following files must exist:
$appgenlibdir/libappgen_appl.a
$appgenlibdir/libappgen_strings.a
$appgenlibdir/libappgen.a

EOT
  print "Enter APPGEN library path here: ";
  ($appgenlibdir=<STDIN>) =~ s/[\s\n\r]//sg;
}

WriteMakefile(
    'NAME'		=> 'DB::Appgen',
    'VERSION_FROM'	=> 'Appgen.pm',
    'PREREQ_PM'		=> { Error => 0.13
                           },
    'LIBS'		=> [ '-L' . $appgenlibdir .
                             ' -lappgen_appl -lappgen -lappgen_strings' .
                             ' -lncurses'
                           ],
    'DEFINE'		=> '',
    'INC'		=> '',
    'MYEXTLIB'		=> 'aglib/libappgen$(LIB_EXT)',
    'clean'		=> {'FILES' => 'test.db' },
);

sub MY::postamble
{ <<'EOT';
$(MYEXTLIB): aglib/Makefile
	cd aglib && $(MAKE) $(PASSTHRU)
EOT
}
