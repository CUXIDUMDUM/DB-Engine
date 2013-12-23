package DMT::Engine::Sqlite::Command::createdb;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;
use Path::Class qw(file dir);

extends 'DMT::Engine::Sqlite::Command';
with 'DMT::Roles::Command::createdb';

sub abstract {

    return q(Create a sqlite database file);
}

sub _create_database {
	my ($self) = @_;

    $self->logger->info(q(Start));

	$self->database->dir->mkpath(1)
        if not -d $self->database->dir->stringify;
	$self->database->touch;

    $self->logger->info(q(Done));

	return;
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

DMT::Engine::Sqlite::createdb

=head1 DESCRIPTION

Create a sqlite database file

=cut
