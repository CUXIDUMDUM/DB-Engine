package DMT::Roles::Command::Core;

use Moose::Role;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use IPC::Run3;

sub _call_run3 {
    shift;
    my $cmd    = shift;
    my $stdin  = shift || \undef;

    my $stderr = sub { say $_ for @_; };
    my $stdout = sub { say $_ for @_; };

    say qq(running $cmd );
    run3(
        $cmd,
        $stdin,
        $stdout,
        $stderr,
    );

    croak if $?;
    return;
}

1;
