package DMT::DBI;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;
use DBIx::Connector;

use DMT::DBI::Conf;

has 'dbi_conf' => (
    is      => 'ro',
    isa     => 'DMT::DBI::Conf',
    builder => '_build_dbi_conf',
);

sub _build_dbi_conf {

    return DMT::DBI::Conf->new();
}

sub get_db_conn {
    my ($self, $db_key) = @_;

    my $dsn      = $self->dbi_conf->get_property($db_key, "dsn");
    my $user     = $self->dbi_conf->get_property($db_key, "user");
    my $password = $self->dbi_conf->get_property($db_key, "password");
    my $attrs    = $self->dbi_conf->get_property($db_key, "attrs");

    return DBIx::Connector->new($dsn, $user, $password, $attrs);
}


1;
