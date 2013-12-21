package DMT::Engine::Sqlite::dumpdb;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

extends 'DMT::Engine::Sqlite::Command';
with 'DMT::Roles::Command::dumpdb';

sub _dump_database {
    my ($self) = @_;

    return;

}

1;
