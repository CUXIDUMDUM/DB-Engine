package DMT::Roles::Command::dumpdb;

use Moose::Role;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

with 'DMT::Roles::Command::Core';
requires qw(_dump_database);

sub execute {
    my ($self) = @_;

    $self->_dump_database();
}

1;
