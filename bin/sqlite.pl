#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;
use FindBin;
use File::Spec;
use lib File::Spec->catfile($FindBin::Bin, '..', 'lib');
use lib File::Spec->catfile($FindBin::Bin, '..', 't', 'lib');
use Data::Dump qw/dump/;
use English qw( -no_match_vars );
use Carp;
use Readonly;

use DMT::Engine::Sqlite;

my $o = DMT::Engine::Sqlite->new();
$o->run();

__END__

=head1 NAME

sqlite.pl

=head1 DESCRIPTION

utility to run sqlite commands to create, drop database and dump database.

=head1 SYNOPSIS

bin/sqlite.pl

bin/sqlite.pl help

bin/sqlite.pl help createdb

bin/sqlite createdb [createdb options]

=cut

