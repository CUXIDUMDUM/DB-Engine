package DMT::Roles::Command::Core;

use Moose::Role;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use IPC::Run3;

with 'DMT::Roles::Logger';

sub _call_run3 {
    my ($self) = shift;
    my $cmd    = shift;
    my $stdin  = shift || \undef;

    my $stderr = sub { $self->logger->warn($_) for @_; };
    my $stdout = sub { $self->logger->info($_) for @_; };

    $self->logger->debug(qq(running $cmd ));

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
