package DMT::Engine::Sqlite::Command;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;
use Readonly;

extends 'MooseX::App::Cmd::Command';
with 'MooseX::SimpleConfig';
with 'DMT::Roles::Command::Core';

Readonly my $SQLITE3      => q(/usr/bin/sqlite3);

has 'database' => (
    is       => 'ro',
    isa      => 'Path::Class::File',
    coerce   => 1,
    required => 1,
    documentation => q(Full path to database file),
);

has '+logger' => (
    traits => [qw/NoGetopt/],
);

has '+configfile' => (
    documentation => 'yaml config file to specify all command line options',
);

has '+log4perl_conf' => (
    documentation => 'config file for Log::Log4perl. default etc/log4perl.conf',
);

sub _get_sqlite3_cli {
    my ($self) = @_;

    return qq( $SQLITE3 );
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

DMT::Engine::Sqlite::Command

=head1 DESCRIPTION

Base class for all DMT::Engine::Sqlite::Command::* commands

=cut
