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

=head1 METHODS

=head2 native_type_map

 my $hashref = FFI::Platypus::Lang::CPP->native_type_map;

This returns a hash reference containing the native aliases for the
C++ programming languages.  That is the keys are native C++ types and the
values are libffi native types.

=cut

sub native_type_map
{
  require FFI::Platypus::Lang::C;
  return FFI::Platypus::Lang::C->native_type_map;
}

1;

=head1 SEE ALSO

=over 4

=item L<FFI::Platypus>

The Core Platypus documentation.

=back

=cut

