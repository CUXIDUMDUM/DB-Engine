package DMT::Engine::Mysql::Command::createdb;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;

extends 'DMT::Engine::Mysql::Command';
with 'DMT::Roles::Command::createdb';

has 'database' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 1,
    documentation => 'Name of the database to be created. Mandatory option.',
);

sub abstract {

    return q(Create a MYSQL database);
}

sub _get_create_ddl {
    my ($self) = @_;

    return q(') . q(CREATE DATABASE ) . $self->database . q(');
}

sub _create_database_command {
    my ($self) = @_;

    my $cli = $self->_get_mysql_cli();
    $cli .= q( --batch -e ) . $self->_get_create_ddl();

    return $cli;
}

sub _create_database {
    my ($self) = @_;

    $self->logger->info(q(Start));

    $self->_call_run3( $self->_create_database_command() );

    $self->logger->info(q(Done));
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

DMT::Engine::Mysql::Command::createdb

=head1 DESCRIPTION

Create a mysql database using the mysql command 

=head1 PARAMETERS

=over 1

=item user

mysql username 

=item password

mysql password

=item database

name of the mysql database to be created

=item configfile

configfile file to contain all command line options.
Any options provided on the command line would 
be treated as overriden parameter

=item log4perl_conf

log4perl_conf file

=back

=cut
