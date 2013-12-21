package DMT::Engine::Sqlite::Command;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use Readonly;

extends 'MooseX::App::Cmd::Command';
with 'MooseX::SimpleConfig';

Readonly my $SQLITE3      => q(/usr/bin/sqlite3);

sub _get_sqlite3_cli {
    my ($self) = @_;

    return qq( $SQLITE3 );
}

1;
