MRuby::Gem::Specification.new('mruby-mrbgem-template') do |spec|
  spec.license = 'MIT'
  spec.authors = 'MATSUMOTO Ryosuke'
  spec.version = '0.0.1'
  spec.bins = %w(mrbgem-template)
  spec.add_dependency('mruby-io')
  spec.add_dependency('mruby-dir')
  spec.add_dependency('mruby-time')
end
