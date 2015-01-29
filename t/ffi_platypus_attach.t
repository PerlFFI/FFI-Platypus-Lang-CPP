use strict;
use warnings;
use Test::More;
use FFI::CheckLib qw( find_lib );
use FFI::Platypus;

my $libtest = find_lib lib => 'test', libpath => 'libtest';
plan skip_all => 'test requires a rust compiler'
  unless $libtest;

plan tests => 2;

my $ffi = FFI::Platypus->new;
$ffi->lang('CPP');
$ffi->lib($libtest);

$ffi->attach( c_int_sum => ['int', 'int'] => 'int');

is c_int_sum(1,2), 3, 'c_int_sum(1,2) = 3';

$ffi->attach( ['MyInteger::int_sum(int, int)' => 'cpp_int_sum'] => ['int','int'] => 'int');

is cpp_int_sum(1,2), 3, 'cpp_int_sum(1,2) = 3';
