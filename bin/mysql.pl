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
