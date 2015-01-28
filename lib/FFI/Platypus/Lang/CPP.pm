package FFI::Platypus::Lang::CPP;

use strict;
use warnings;
use FFI::Platypus;

our $VERSION = '0.01';

=head1 NAME

FFI::Platypus::Lang::CPP - Documentation and tools for using Platypus with
the C++ programming language

=head1 SYNOPSIS

 use FFI::Platypus;
 my $ffi = FFI::Platypus->new;
 $ffi->with('CPP');

=head1 DESCRIPTION

This module provides some hooks for Platypus to interact with the 
C++ programming language.

=cut

sub primitive_type_map
{
  { # should be the same as C
  },
}

1;
