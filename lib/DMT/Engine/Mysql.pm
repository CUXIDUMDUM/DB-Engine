package DMT::Engine::Mysql;

use Moose;
use namespace::autoclean;
use 5.016;
use Data::Dump qw(dump);
use Carp;

extends 'MooseX::App::Cmd';

__PACKAGE__->meta->make_immutable();

1;

=head1 NAME

DMT::Engine::Mysql

=head1 SYNOPSIS

in some bin/mysql.pl

use DMT::Engine::Mysql;

my $o = DMT::Engine::Mysql->new();

$o->run();

and then

$ bin/mysql.pl help

$ bin/mysql.pl help command

$ bin/mysql.pl command [<args>]

=cut
