package DMT::Engine::Sqlite::dropdb;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

extends 'DMT::Engine::Sqlite::Command';
with 'DMT::Roles::Command::dropdb';

sub _get_drop_ddl {
    my ($self) = @_;

}

sub _drop_database {
    my ($self) = @_;


}

1;
