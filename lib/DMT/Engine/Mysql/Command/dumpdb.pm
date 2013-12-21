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

1;

__END__

=head1 NAME

DMT::Engine::Mysql::Command::dropdb

=head1 COMMAND OPTIONS

=over 1

=item user

=item password

=item databases

=over 1

list of databases to be dumped. 
to be used as 
--databases foo --databases bar

=back

=item configfile

=item log4perl_conf

=item dump_dir


=back

=cut

