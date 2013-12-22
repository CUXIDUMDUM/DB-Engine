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

use DMT::Engine::Mysql;

my $o = DMT::Engine::Mysql->new();
$o->run();

__END__

=head1 NAME

mysql.pl

=head1 DESCRIPTION

utility to run mysql commands to create, drop database and dump database.

=head1 SYNOPSIS

bin/mysql.pl

bin/mysql.pl help

bin/mysql.pl help createdb

bin/mysql createdb [createdb options]

=cut

