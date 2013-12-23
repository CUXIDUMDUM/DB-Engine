#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;
use FindBin;
use File::Spec;
use lib File::Spec->catfile($FindBin::Bin, '..', 'lib');
use lib File::Spec->catfile($FindBin::Bin, '..', 't', 'lib');
use Data::Dump qw/dump/;
use Test::More;
use Test::Exception;
use Test::Deep;
use English qw( -no_match_vars );
use Carp;
use Readonly;
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($DEBUG);

{
    package Bar;

    use Moose;
    use namespace::autoclean;

    sub test_die {

        die "This should be captured in the logger";
    }
}


{
    package Foo;

    use Moose;
    use namespace::autoclean;
    with 'DMT::Roles::Logger';
    
    sub test_die {

        my $o = Bar->new();
        $o->test_die();
    }
}


my $foo = Foo->new();

for my $level ( qw/debug info warn error fatal/ ) {
    ok ( $foo->logger->$level("Testing $level") , "$level ok");
}

{
    eval {
        #override any SIG{DIE} locally
        local $SIG{__DIE__} = sub { 
            diag "Message from die inserted in Logger WARN";
            LOGCLUCK(@_); #dump full stack trace
        };
        $foo->test_die();
    };
}

for my $level ( qw/logdie logcroak logconfess/ ) {

    eval { $foo->logger->$level("Testing $level"); };
    ok( $@, "$level thorws exception");
}

done_testing();
