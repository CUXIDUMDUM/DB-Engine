package DMT::Roles::Command::dropdb;

use Moose::Role;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

with 'DMT::Roles::Command::Core';

requires qw(_drop_database);

sub execute {
    my ($self) = @_;

    $self->_drop_database();

}

1;
