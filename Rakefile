MRUBY_CONFIG=File.expand_path(ENV["MRUBY_CONFIG"] || "build_config.rb")
TEMPLATE_CONFIG=File.expand_path(ENV["TEMPLATE_CONFIG"] || "template_config.rb")
MRUBY_VERSION=ENV["MRUBY_VERSION"] || "2.1.2"

file :mruby do
  sh "git clone --depth=1 https://github.com/mruby/mruby.git"
  if MRUBY_VERSION != "master"
    Dir.chdir 'mruby' do
      sh "git fetch --tags"
      rev = %x{git rev-parse #{MRUBY_VERSION}}
      sh "git checkout #{rev}"
    end
  end
end

desc "compile binary"
task :compile => :mruby do
  sh "cd mruby && rake all MRUBY_CONFIG=\"#{MRUBY_CONFIG}\""
  sh "./mruby/bin/mruby \"#{TEMPLATE_CONFIG}\""
end

desc "test"
task :test => :mruby do
  sh "cd mruby && rake all test MRUBY_CONFIG=\"#{MRUBY_CONFIG}\""
end

desc "cleanup"
task :clean do
  sh "cd mruby && rake deep_clean"
end

task :default => :compile
