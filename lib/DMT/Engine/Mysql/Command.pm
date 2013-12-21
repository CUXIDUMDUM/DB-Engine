package DMT::Engine::Mysql::Command;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use Readonly;
use File::Which qw( which );

extends 'MooseX::App::Cmd::Command';
with 'MooseX::SimpleConfig';
with 'DMT::Roles::Command::Core';

Readonly my $MYSQL      => q(mysql);
Readonly my $MYSQLADMIN => q(mysqladmin);
Readonly my $MYSQLDUMP  => q(mysqldump);

for my $attr (qw( user password host port )) {
    has $attr => (
        is        => 'rw',
        isa       => 'Str',
        predicate => '_has_' . $attr,
    );
}

has '+logger' => (
    traits => [qw/NoGetopt/],
);

sub _get_mysql_cli {
    my ($self) = @_;

    my @cmd;

    my $executable = which($MYSQL);
    die "Cannot find $MYSQL in your path" if not defined $executable;
    die "$MYSQL not executable" if not -x $executable;

    push @cmd, $MYSQL;
    push @cmd, q( --user=)     . $self->user if defined $self->user;
    push @cmd, q( --password=) . $self->password if defined $self->password;
    push @cmd, q( --host ) . $self->host if defined $self->host;
    push @cmd, q( --port ) . $self->port if defined $self->port;

    return wantarray ? @cmd : "@cmd";
}

sub _get_mysqldump_cli {
    my ($self) = @_;

    my $executable = which($MYSQLDUMP);
    die "Cannot find $MYSQLDUMP in your path" if not defined $executable;
    die "$MYSQLDUMP not executable" if not -x $executable;

    my @cmd;
    push @cmd, $MYSQLDUMP;
    push @cmd, q( --user=)     . $self->user if defined $self->user;
    push @cmd, q( --password=) . $self->password if defined $self->password;
    push @cmd, q( --host ) . $self->host if defined $self->host;
    push @cmd, q( --port ) . $self->port if defined $self->port;

    return wantarray ? @cmd : "@cmd";
}

1;
