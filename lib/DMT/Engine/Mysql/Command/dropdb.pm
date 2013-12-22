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

sub abstract {

    return q(Drop a MYSQL database);
}

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

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

DMT::Engine::Mysql::Command::dropdb

=head1 DESCRIPTION

Drop a mysql database

=head1 PARAMETERS

=over 1

=item user

mysql username

=item password

mysql password

=item database

name of the mysql database to drop

=item configfile

configfile file to contain all command line options.
Any options provided on the command line would 
be treated as overriden parameter

=item log4perl_conf

log4perl_conf file

=back

=cut

