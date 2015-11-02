MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'full-core'
  conf.gem './'
end
