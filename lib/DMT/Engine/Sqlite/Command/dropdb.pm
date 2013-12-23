package DMT::Engine::Sqlite::Command::dropdb;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;
use Path::Class qw(file dir);

extends 'DMT::Engine::Sqlite::Command';
with 'DMT::Roles::Command::dropdb';

sub abstract {

    return q(Drop a sqlite database),
}

sub _drop_database {
	my ($self) = @_;

    $self->logger->info(q(Start));

	$self->database->remove
		or $self->logger->logdie(
		q(Could not remove database file ) . $self->database );

    $self->logger->info(q(Done));

	return;
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

DMT::Engine::Sqlite::dropdb

=head1 DESCRIPTION

Drop a sqlite database (Unlink the database file)

=cut
