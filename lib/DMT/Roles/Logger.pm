package DMT::Roles::Logger;

use strict;
use warnings;
use 5.016;

use English qw( -no_match_vars );
use Carp;
use Readonly;
use Data::Dump qw(dump);
use Log::Log4perl qw(:easy);

use Moose::Role;
use namespace::autoclean;
use MooseX::StrictConstructor;
use MooseX::Types::Path::Class;

has 'logger' => (
    is         => 'ro',
    isa        => 'Log::Log4perl::Logger',
    lazy_build => 1,
);

has 'log4perl_conf' => (
    is        => 'rw',
    isa       => 'Str',
    default   => q(etc/log4perl.conf),
    predicate => 'has_log4perl_conf',
);

sub _build_logger {
    my ($self) = @_; 
    my $log = Log::Log4perl::Logger->get_logger(__PACKAGE__);

    $SIG{__DIE__} = sub {
        if($^S) {
            # We're in an eval {} and don't want log
            # this message but catch it later
            return;
        }
        $Log::Log4perl::caller_depth++;
        $log->logcroak(@_);
    };

    unless ( Log::Log4perl->initialized() ) { 
        if ( $self->has_log4perl_conf and -e $self->log4perl_conf ) { 
            Log::Log4perl->init( $self->log4perl_conf );
        }   
        else {
            Log::Log4perl->easy_init($DEBUG);
        }   
    }   
    return $log;
}

1;

__END__

=head1 NAME

DMT::Roles::Logger: Role for logging

=head1 VERSION

0.01

=head1 SYNOPSIS

package Foo;

use Moose;

with 'DMT::Roles::Logger';

=head1 DESCRIPTION

DMT::Roles::Logger: Role for logging

in some method 

sub foo { 

    my ($self) = @_;

    $self->logger->debug(..);
    $self->logger->info(..);
    $self->logger->warn(..);
    $self->logger->error(..);
    $self->logger->fatal(..);

}
    
Also refer perldoc Log::Log4perl

=cut
