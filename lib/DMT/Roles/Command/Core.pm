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
    
    my $output = q();
    my $error  = q();

    my $stderr = sub { 
        for (@_) {
            $self->logger->warn($_) for @_;
            $error .= $_;
        }
    };
    my $stdout = sub { 
        for (@_) {
            $self->logger->warn($_) for @_;
            $output .= $_;
        }
    };

    $self->logger->debug(qq(Running [$cmd] ));

    return if $self->dry_run;

    run3(
        $cmd,
        $stdin,
        $stdout,
        $stderr,
    );

    my $exit_code = $? >> 8;

    die q(Command Failed with exit code ) . $exit_code
        if $exit_code;

    return $output;
}

1;
