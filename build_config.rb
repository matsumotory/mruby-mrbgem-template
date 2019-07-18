MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'full-core'
  conf.gem './'

  conf.enable_debug if ENV['DEBUG']
end
