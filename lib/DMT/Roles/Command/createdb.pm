package DMT::Roles::Command::createdb;

use Moose::Role;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

with 'DMT::Roles::Command::Core';

requires qw(_create_database);

sub execute{
    my ($self) = @_;

    $self->_create_database();
}

1;
