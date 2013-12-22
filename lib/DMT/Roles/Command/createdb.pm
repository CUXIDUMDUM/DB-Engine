package DMT::Roles::Command::createdb;

use Moose::Role;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;

requires qw(_create_database);

sub execute{
    my ($self) = @_;

    $self->_create_database();
}

1;

__END__

=head1 NAME

DMT::Roles::Command::createdb

=head1 DESCRIPTION

This role will ensure the consuming class provides the _create_database method

=cut
