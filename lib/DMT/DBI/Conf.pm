package DMT::DBI::Conf;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;

has 'config_fn' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    builder  => '_build_config_fn',
);

sub _build_config_fn {

    return q(etc/dbi.yml);
}

has 'configs' => (
    is      => 'ro',
    isa     => 'HashRef',
    lazy    => 1,
    builder => '_build_configs',
);

sub _build_configs {
    my ($self) = @_;

    return LoadFile($self->config_fn);
}

sub get_property {
    my ($self, $db_key, $property) = @_;

    confess qq(Invalid $db_key)
        if not exists $self->configs->{$db_key};

    confess qq(Invalid property $property)
        if not exists $self->configs->{$db_key}->{$property};

    return $self->configs->{$db_key}->{$property};
}

1;
