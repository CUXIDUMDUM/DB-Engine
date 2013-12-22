package DMT::Engine::Sqlite::createdb;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;

extends 'DMT::Engine::Sqlite::Command';
with 'DMT::Roles::Command::createdb';

sub _get_create_ddl {
    my ($self) = @_;

}

sub _create_database {
    my ($self) = @_;

}

1;
