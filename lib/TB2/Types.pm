package TB2::Types;

use TB2::Mouse ();
use TB2::Mouse::Util qw(load_class);
use TB2::Mouse::Util::TypeConstraints;

our $VERSION = '1.005000_006';
$VERSION = eval $VERSION;    ## no critic (BuiltinFunctions::ProhibitStringyEval)


=head1 NAME

TB2::Types - Mouse types used by Test::Builder2

=head1 SYNOPSIS

    use TB2::Types;

=head1 DESCRIPTION

This defines custom Mouse types used by Test::Builder2.

=head2 Types

=head3 TB2::Positive_Int

An integer greater than or equal to zero.

=cut

subtype 'TB2::Positive_Int' => (
    as 'Int',
    where { $_ >= 0 },
);


=head3 TB2::Positive_NonZero_Int

An integer greater than zero.

=cut

subtype 'TB2::Positive_NonZero_Int' => (
    as 'Int',
    where { $_ > 0 },
);


=head3 TB2::NonZero_Int

An integer which is not zero.

=cut

subtype 'TB2::NonZero_Int' => (
    as 'Int',
    where { $_ != 0 },
);


=head3 TB2::LC_AlphaNumUS_Str

A lowercase string containing only alphanumerics & underscores.

=cut

subtype 'TB2::LC_AlphaNumUS_Str' => (
    as 'Str',
    where { /^[a-z0-9_]+$/ },
);


=head3 TB2::LoadableClass

A class name.  It will be loaded.

=cut

subtype 'TB2::LoadableClass', as 'ClassName';
coerce 'TB2::LoadableClass', from 'Str', via { load_class($_); $_ };

=head3 TB2::Stringify

References stringifier class. It will coerce ref to string.

=cut

subtype 'TB2::Stringify', as 'Str';
coerce 'TB2::Stringify', from 'Ref', via { "$_" };


# Pre-declare some things as classes so we don't have to load them just
# to get the types to turn out right.
my @classes = qw(
    File::Temp
);
for my $class (@classes) { class_type($class) }

no TB2::Mouse::Util::TypeConstraints;

1;
