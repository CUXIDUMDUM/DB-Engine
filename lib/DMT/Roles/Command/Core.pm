package DMT::Roles::Command::Core;

use Moose::Role;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;
use IPC::Run3;

with 'DMT::Roles::Logger';

has 'dry_run' => (
    is            => 'ro',
    isa           => 'Bool',
    documentation => 'Do not run any system commands',
    default       => 0,
);

sub _call_run3 {
    my ($self) = shift;
    my $cmd    = shift;
    my $stdin  = shift || \undef;

    my $stderr = sub { $self->logger->warn($_) for @_; };
    my $stdout = sub { $self->logger->info($_) for @_; };

    $self->logger->debug(qq(running $cmd ));

    return if $self->dry_run;

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
