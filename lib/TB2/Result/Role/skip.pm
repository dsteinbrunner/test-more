package TB2::Result::Role::skip;

use Mouse ();
use Mouse::Role;

our $VERSION = '1.005000_001';
$VERSION = eval $VERSION;    ## no critic (BuiltinFunctions::ProhibitStringyEval)


sub is_skip { 1 }

no Mouse::Role;

1;


=head1 NAME

TB2::Result::Role::skip - The assert did not run

=head1 DESCRIPTION

Apply this role to a Result::Base object if the assert was not run, it
was skipped.

=cut
