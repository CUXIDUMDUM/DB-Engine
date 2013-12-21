package DMT::Engine::Mysql::Command::dropdb;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

extends 'DMT::Engine::Mysql::Command';
with 'DMT::Roles::Command::dropdb';

has 'database' => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

sub _get_drop_ddl {
    my ($self) = @_;

    return q(') . q(DROP DATABASE ) . $self->database . q(');
}

sub _drop_database_command {
    my ($self) = @_;

    my $cli = $self->_get_mysql_cli();
    $cli .= q( --batch -e ) . $self->_get_drop_ddl();

    return $cli;
}

sub _drop_database {
    my ($self) = @_;

    $self->_call_run3( $self->_drop_database_command() );

    return;
}

1;
