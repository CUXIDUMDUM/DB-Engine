package DMT::Roles::Command::dropdb;

use Moose::Role;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;

requires qw(_drop_database);

sub execute {
    my ($self) = @_;

    $self->_drop_database();

}

1;

__END__

=head1 NAME

DMT::Roles::Command::dropdb

=head1 DESCRIPTION

This role will ensure the consuming class provides the _drop_database method

=cut


