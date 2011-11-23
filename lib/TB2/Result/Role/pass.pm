package TB2::Result::Role::pass;

use Mouse ();
use Mouse::Role;

our $VERSION = '1.005000_001';
$VERSION = eval $VERSION;    ## no critic (BuiltinFunctions::ProhibitStringyEval)


sub literal_pass { 1 }

no Mouse::Role;

1;


=head1 NAME

TB2::Result::Role::pass - The assert passed

=head1 DESCRIPTION

Apply this role to a Result::Base object if the assert passed.

=cut
