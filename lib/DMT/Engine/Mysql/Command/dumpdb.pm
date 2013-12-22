package DMT::Engine::Mysql::Command::dumpdb;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use Path::Class qw(file dir);

extends 'DMT::Engine::Mysql::Command';
with 'DMT::Roles::Command::dumpdb';

has 'databases' => (
    is       => 'ro',
    isa      => 'ArrayRef',
    required => 1,
    default  => sub { [] },
);

has 'dump_dir' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    default  => q(/tmp),
);

sub abstract {

    return q(Dump MYSQL databases(s) to a directory);

}

sub _dump_database_command {

    my ($self) = @_;

    return $self->_get_mysqldump_cli() . q( --databases );
}

sub _dump_database {
    my ($self) = @_;

    my $dir = dir( $self->dump_dir );
    $dir->mkpath(1) unless -d $dir->stringify;

    for my $db ( @{ $self->databases } ) {

        my $file = file( $dir, $db );
        my $cmd = $self->_dump_database_command() . qq( $db ) . q( > ) . $file;
        $self->_call_run3($cmd);
    }

    return;

}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

DMT::Engine::Mysql::Command::dumpdb

=head1 DESCRIPTION

dump mysql database(s) to files using the mysqldump command line utility

=head1 PARAMETERS

=over 1

=item user

mysqldump user name

=item password

mysqldump password

=item databases

list of databases to be dumped. 
To be used as --databases foo --databases bar.
Refer perldoc MooseX::Getopt for more details

=item configfile

configfile file to contain all command line options.
Any options provided on the command line would 
be treated as overriden parameter

=item log4perl_conf

Full path to log4perl conf file

=item dump_dir

A directory where mysql database would be dumped.

The file would be dumped as 

if command line has options as 
--database foo --database bar --dump_dir /tmp/dumpdir,

then files would be 
/tmp/dumpdir/foo
/tmp/dumpdir/bar

=back

=cut

