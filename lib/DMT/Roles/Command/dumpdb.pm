package DMT::Roles::Command::dumpdb;

use Moose::Role;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;

requires qw(_dump_database);

sub execute {
    my ($self) = @_;

    $self->_dump_database();
}

1;

__END__

=head1 NAME

DMT::Roles::Command::dumpdb

=head1 DESCRIPTION

This role will ensure the consuming class provides the _dump_database method

=cut

