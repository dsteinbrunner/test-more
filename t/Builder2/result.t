#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More 'no_plan';

my $CLASS = 'Test::Builder2::Result';
require_ok $CLASS;

my $new_ok = sub {
    my $result = $CLASS->new(@_);
    isa_ok $result, 'Test::Builder2::Result';
    return $result;
};


# Pass
{
    my $result = $new_ok->( raw_passed => 1 );
    isa_ok $result, "Test::Builder2::Result";

    ok $result->passed;
    ok $result->raw_passed;
}


# Fail
{
    my $result = $new_ok->( raw_passed => 0 );
    isa_ok $result, "Test::Builder2::Result";

    ok !$result->passed;
    ok !$result->raw_passed;
}


# Skip
{
    my $result = $new_ok->(
        raw_passed      => 1,
        skip            => 1,
    );
    isa_ok $result, "Test::Builder2::Result";

    ok $result->passed;
    ok $result->raw_passed;
    is $result->directive,      'skip';
}


# TODO
{
    my $result = $new_ok->(
        raw_passed      => 0,
        todo            => 1,
    );
    isa_ok $result, "Test::Builder2::Result";

    ok $result->passed;
    ok !$result->raw_passed;
    is $result->directive,      'todo';
}


# Unknown directive, pass
{
    my $result = $new_ok->(
        directive       => 'omega',
        raw_passed      => 1
    );

    isa_ok $result, "Test::Builder2::Result";

    ok $result->passed;
    ok $result->raw_passed;
    is $result->directive,      'omega';
}


# Unknown directive, fail
{
    my $result = $new_ok->(
        directive       => 'omega',
        raw_passed      => 0
    );

    isa_ok $result, "Test::Builder2::Result";

    ok !$result->passed;
    ok !$result->raw_passed;
    is $result->directive,      'omega';
}

# truthiness (FALSE)
{
    my $result = $new_ok->(
        raw_passed => 0
    );
    isa_ok $result, "Test::Builder2::Result";
    ok !$result, "truth check";
}

# truthiness (TRUE)
{
    my $result = $new_ok->(
        raw_passed => 1
    );
    isa_ok $result, "Test::Builder2::Result";
    ok $result, "truth check";
}


# as_hash
{
    my $result = $new_ok->(
        raw_passed      => 1,
        description     => 'something something something test result',
        test_number     => 23,
        location        => 'foo.t',
        id              => 0,
        directive       => '',
    );

    is_deeply $result->as_hash, {
        raw_passed      => 1,
        description     => 'something something something test result',
        test_number     => 23,
        passed          => 1,
        location        => 'foo.t',
        id              => 0,
        directive       => '',
    }, 'as_hash';
}


