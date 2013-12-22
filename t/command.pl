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
use Test::More;
use Test::Exception;

{
    package MooseX::App::Cmd::Command;
    
    use Moose;
    use namespace::autoclean;
}

my @commands = qw(createdb dropdb dumpdb);

for my $cmd ( @commands ) {

    {
        my $CLASS = q(DMT::Engine::Mysql::Command::) . lc($cmd);
        use_ok($CLASS);
        my $configfile = File::Spec->catfile('t', 'etc', qq($cmd) . '.yml');

        my $object = $CLASS->new_with_config( configfile => $configfile, dry_run => 1, );
        isa_ok($object, $CLASS);
        can_ok($object, q(execute));

        ok( $object->meta->does_role(q(DMT::Roles::Command::Core) ), 'Does Role DMT::Roles::Command::Core');
        ok( $object->meta->does_role(q(DMT::Roles::Command::) . $cmd), 'Does Role DMT::Roles::Command::' . $cmd);

        lives_ok { $object->execute } 'Command Executed Successfully in Dry Run';
    }
}

done_testing();
