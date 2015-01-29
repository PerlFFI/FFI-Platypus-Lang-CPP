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

Generally you will not use this class directly, instead interacting with
the L<FFI::Platypus> instance.  However, the public methods used by
Platypus are documented here.

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

=head2 mangler

 my $mangler = FFI::Platypus::Lang::CPP->mangler($ffi->libs);
 print $mangler->("_ZN9MyInteger7int_sumEii") # prints MyInteger::int_sum(int, int)

Returns a subroutine reference that will "mangle" C++ names.

=cut

sub mangler
{
  my($class, @libs) = @_;
  
  my %mangle;
  
  foreach my $libpath (@libs)
  {
    require Parse::nm;
    Parse::nm->run(
      files => $libpath,
      filters => [ {
        action => sub {
          my $c_symbol = $_[0];
          # TODO: what to do if we do not have c++filt?
          my $cpp_symbol = `c++filt $c_symbol`;
          chomp $cpp_symbol;
          return if $c_symbol eq $cpp_symbol;
          $mangle{$cpp_symbol} = $c_symbol;
        },
      } ],
    );
  }
  
  sub {
    defined $mangle{$_[0]} ? $mangle{$_[0]} : $_[0];
  };
}

1;

=head1 SEE ALSO

=over 4

=item L<FFI::Platypus>

The Core Platypus documentation.

=back

=cut

