require_relative "mrblib/version"

MRuby::Gem::Specification.new('mruby-mrbgem-template') do |spec|
  spec.license = 'MIT'
  spec.authors = 'MATSUMOTO Ryosuke'
  spec.version = MrbgemTemplate::VERSION
  spec.bins = %w(mrbgem-template)

  spec.add_dependency('mruby-io')
  spec.add_dependency('mruby-dir')
  spec.add_dependency('mruby-time')
  spec.add_dependency('mruby-optparse', github: 'fastly/mruby-optparse')
end
