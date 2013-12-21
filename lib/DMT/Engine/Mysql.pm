package DMT::Engine::Mysql;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

extends 'MooseX::App::Cmd';

1;

=head1 NAME

DMT::Engine::Mysql

=head1 SYNOPSIS

in some bin/mysql.pl

use DMT::Engine::Mysql;

my $o = DMT::Engine::Mysql->new();

$o->run();

and then

$ perl bin/mysql.pl help

$ perl bin/mysql.pl help command

$ perl bin/mysql.pl command [<args>]


=cut
