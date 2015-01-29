BEGIN {
  unless(eval q{ use 5.008001; 1 }) {
    print "Perl 5.008001 or better required\n";
    exit;
  }
}
use strict;
use warnings;
use lib 'inc';
use lib 'lib';
use My::ModuleBuild;
use Env qw( @PATH );
use ExtUtils::CBuilder;
use File::Spec;

unless(ExtUtils::CBuilder->new->have_cplusplus)
{
  print "Unable to find C++.  Please make sure it is in the PATH.\n";
  print "You should still be able to use pre-compiled C++ dynamic libs.\n";
}

my $builder = My::ModuleBuild->new(
  module_name   => 'FFI::Platypus::Lang::CPP',
  dist_abstract => 'Documentation and tools for using Platypus with the C++ '.
                   'programming language',
  dist_author   => [ 'Graham Ollis <plicease@cpan.org>' ],
  license       => 'perl',
  configure_requires => {
    'Module::Build'      => 0.38,
    'ExtUtils::CBuilder' => 0,
  },
  build_requires => {
  },
  requires => {
    'perl',         => '5.008001',
    'FFI::Platypus' => '0.16',
    'Parse::nm'     => 0,
  },
  meta_merge => {
    resources  => {
      repository => "http://github.com/plicease/FFI-Platypus-Lang-CPP",
      bugtracker => "http://github.com/plicease/FFI-Platypus-Lang-CPP/issues",
    },
    no_index => {
      directory => [ 'examples' ],
    },
  },
);

$builder->add_to_cleanup(
  '*.bak',
  'FFI-Platypus-Lang-CPP-*',
);

$builder->create_build_script;
